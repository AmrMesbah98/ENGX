part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetUserDataLoading extends ProfileState {}

final class GetUserDataSuccess extends ProfileState {}

final class GetUserDataError extends ProfileState {}


class LoadingInformationState extends ProfileState {}
class SuccsessInformationState extends ProfileState {}
class ErrorInformationState extends ProfileState {}
