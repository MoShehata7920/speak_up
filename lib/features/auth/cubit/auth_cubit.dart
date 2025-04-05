import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speak_up/core/repo.dart';
import 'package:speak_up/features/auth/cubit/auth_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class AuthCubit extends Cubit<AuthState> {
  final supabase.SupabaseClient supabaseClient;
  final Repository repository;

  AuthCubit(this.supabaseClient, this.repository) : super(AuthInitial());

  Future<void> signUp(String email, String password, String fullName) async {
    try {
      emit(SignUpLoading());

      final authResponse = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );

      if (authResponse.user != null) {
        final userId = authResponse.user!.id;

        await supabaseClient.from('users').insert({
          'id': userId,
          'full_name': fullName,
          'email': email,
        });
        await repository.saveAuthenticationStatus(true);
        emit(SignUpAuthenticated(userId));
      } else {
        emit(
          SignUpError(_formatErrorMessage('No user returned', isSignUp: true)),
        );
      }
    } on supabase.PostgrestException catch (e) {
      emit(SignUpError(_formatErrorMessage(e, isSignUp: true)));
    } on supabase.AuthException catch (e) {
      emit(SignUpError(_formatErrorMessage(e, isSignUp: true)));
    } catch (e) {
      emit(SignUpError(_formatErrorMessage(e, isSignUp: true)));
    }
  }

  Future<void> logIn(String email, String password) async {
    try {
      emit(LoginLoading());

      final authResponse = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (authResponse.user != null) {
        await repository.saveAuthenticationStatus(true);
        emit(LoginAuthenticated(authResponse.user!.id));
      } else {
        emit(
          LoginError(_formatErrorMessage('No user returned', isSignUp: false)),
        );
      }
    } on supabase.AuthException catch (e) {
      emit(LoginError(_formatErrorMessage(e, isSignUp: false)));
    } catch (e) {
      emit(LoginError(_formatErrorMessage(e, isSignUp: false)));
    }
  }

  Future<void> signOut() async {
    try {
      emit(SignOutLoading());
      await supabaseClient.auth.signOut();
      await repository.saveAuthenticationStatus(false);
      emit(SignOutSuccess());
    } catch (e) {
      emit(SignOutError(_formatErrorMessage(e, isSignUp: false)));
    }
  }

  String _formatErrorMessage(dynamic error, {required bool isSignUp}) {
    String errorMessage = error.toString().toLowerCase();

    if (isSignUp && errorMessage.contains('database error')) {
      if (errorMessage.contains('duplicate key')) {
        return 'This email is already registered.';
      } else if (errorMessage.contains('permission denied')) {
        return 'Permission denied. Contact support.';
      } else if (errorMessage.contains('foreign key')) {
        return 'Invalid data provided. Please try again.';
      }
      return 'Failed to save your information. Please try again.';
    }

    if (errorMessage.contains('authentication') ||
        error is supabase.AuthException) {
      if (errorMessage.contains('invalid') ||
          errorMessage.contains('invalid login credentials')) {
        return 'Invalid email or password.';
      } else if (errorMessage.contains('email not confirmed')) {
        return 'Please confirm your email before logging in.';
      } else if (errorMessage.contains('too many requests') ||
          errorMessage.contains('rate limit')) {
        return 'Too many attempts. Please wait and try again.';
      } else if (errorMessage.contains('password') &&
          errorMessage.contains('characters')) {
        return 'Password must be at least 6 characters.';
      }
      return 'Authentication failed. Please check your details.';
    }

    if (errorMessage.contains('no user returned')) {
      return '${isSignUp ? 'Sign-up' : 'Login'} failed. Please try again.';
    }

    if (errorMessage.contains('network') ||
        errorMessage.contains('timeout') ||
        errorMessage.contains('connection')) {
      return 'Network error. Please check your connection and try again.';
    }

    if (errorMessage.contains('sign out') || errorMessage.contains('logout')) {
      return 'Failed to sign out. Please try again.';
    }

    debugPrint('Unhandled error: $error');
    return 'An unexpected error occurred. Please try again.';
  }
}
