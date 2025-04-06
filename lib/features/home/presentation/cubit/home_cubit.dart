import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final supabase.SupabaseClient supabaseClient;

  HomeCubit(this.supabaseClient) : super(const HomeState()) {
    loadUserData();
  }

  Future<void> loadUserData() async {
    final user = supabaseClient.auth.currentUser;
    if (user != null) {
      try {
        final response =
            await supabaseClient
                .from('users')
                .select('full_name, profile_image')
                .eq('id', user.id)
                .single();
        emit(
          HomeState(
            fullName: response['full_name'] as String?,
            profileImage: response['profile_image'] as String?,
          ),
        );
      } catch (e) {
        emit(const HomeState(fullName: 'Error', profileImage: null));
      }
    } else {
      emit(const HomeState(fullName: 'Guest', profileImage: null));
    }
  }

  Future<void> refreshUserData() async {
    await loadUserData();
  }
}
