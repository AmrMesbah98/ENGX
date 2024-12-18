part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoadingState extends AuthState {
}
class AuthSuccessUserState extends AuthState {}
class AuthSuccessAdminState extends AuthState {}
class AuthErrorState extends AuthState {
  final String errMessage;

  AuthErrorState(this.errMessage);
}
