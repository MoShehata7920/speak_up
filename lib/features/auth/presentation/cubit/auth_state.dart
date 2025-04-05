import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class SignUpLoading extends AuthState {}

class SignUpAuthenticated extends AuthState {
  final String userId;
  SignUpAuthenticated(this.userId);

  @override
  List<Object?> get props => [userId];
}

class SignUpError extends AuthState {
  final String message;
  SignUpError(this.message);

  @override
  List<Object?> get props => [message];
}

class LoginLoading extends AuthState {}

class LoginAuthenticated extends AuthState {
  final String userId;
  LoginAuthenticated(this.userId);

  @override
  List<Object?> get props => [userId];
}

class LoginError extends AuthState {
  final String message;
  LoginError(this.message);

  @override
  List<Object?> get props => [message];
}

class SignOutLoading extends AuthState {}

class SignOutSuccess extends AuthState {}

class SignOutError extends AuthState {
  final String message;
  SignOutError(this.message);

  @override
  List<Object?> get props => [message];
}
