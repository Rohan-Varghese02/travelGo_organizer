part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

sealed class AuthActionState extends AuthState {}

final class AuthInitial extends AuthState {}

// Landing Page
class FirstTimeLoading extends AuthState {}

class OnceLoadedState extends AuthState {}

// Login Page
class LoginPageNavigationState extends AuthState {}

class LoginSuccessState extends AuthState {
  final UserCredential userCredential;

  LoginSuccessState({required this.userCredential});
}

class LoginFailedState extends AuthState {
  final String error;

  LoginFailedState({required this.error});
}

class LogoutState extends AuthState {}

class LogoutDailogOpenState extends AuthState {}

class NavigateToRegister extends AuthState {}

class VisibleState extends AuthActionState {
  final bool isVisible;

  VisibleState({required this.isVisible});
}

// Google Services
class GoogleLoginSucess extends AuthState {
  final UserCredential userCredential;

  GoogleLoginSucess({required this.userCredential});
}

class GoogleLoginFailure extends AuthState {
  final String error;

  GoogleLoginFailure({required this.error});
}

//Register Screen

class ReturnToLogin extends AuthState {}

class PasswordConfirmedPassDifferent extends AuthState {}

class ContinueRegisteration extends AuthState {
  final String email;
  final String password;

  ContinueRegisteration({required this.email, required this.password});
}

/// Register screen
///
///
class ProfileImagePicked extends AuthState {
  final String imagePath;
  ProfileImagePicked(this.imagePath);
}

class ProfileImageUploading extends AuthState {}

class ProfileImageUploaded extends AuthState {
  final String imageUrl;
  final String imagePublicId;
  ProfileImageUploaded(this.imageUrl, this.imagePublicId);
}

class ProfileError extends AuthState {
  final String message;
  ProfileError(this.message);
}

class RegisterationError extends AuthState {}

class RegisterSuccessful extends AuthState {}

class NoImageState extends AuthState {}
