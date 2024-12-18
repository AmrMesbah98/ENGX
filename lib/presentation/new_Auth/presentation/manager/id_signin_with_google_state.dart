part of 'id_signin_with_google_cubit.dart';

@immutable
sealed class IdSigninWithGoogleState {}

final class IdSigninWithGoogleInitial extends IdSigninWithGoogleState {}
final class IdSigninWithGoogleLoading extends IdSigninWithGoogleState {}
final class IdSigninWithGoogleSuccess extends IdSigninWithGoogleState {}
final class IdSigninWithGoogleError extends IdSigninWithGoogleState {}