part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

// Login

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginFailure extends AuthState {
  final String errorMessage;
  LoginFailure({required this.errorMessage});
}

// Signup
final class SignupLoading extends AuthState {}

final class SignupSuccess extends AuthState {}

final class SignupFailure extends AuthState {
  final String errorMessage;
  SignupFailure({required this.errorMessage});
}

// forget Password
final class ForgetPasswordLoading extends AuthState {}

final class ForgetPasswordSuccess extends AuthState {}

final class ForgetPasswordFailure extends AuthState {
  final String errorMessage;
  ForgetPasswordFailure({required this.errorMessage});
}
