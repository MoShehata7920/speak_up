abstract class AuthState {}

class AuthInitial extends AuthState {}

class SignUpLoading extends AuthState {}

class SignUpAuthenticated extends AuthState {
  final String userId;
  SignUpAuthenticated(this.userId);
}

class SignUpError extends AuthState {
  final String message;
  SignUpError(this.message);
}

class LoginLoading extends AuthState {}

class LoginAuthenticated extends AuthState {
  final String userId;
  LoginAuthenticated(this.userId);
}

class LoginError extends AuthState {
  final String message;
  LoginError(this.message);
}

class SignOutLoading extends AuthState {}

class SignOutSuccess extends AuthState {}

class SignOutError extends AuthState {
  final String message;
  SignOutError(this.message);
}
