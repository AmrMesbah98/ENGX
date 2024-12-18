part of 'publicnotification_cubit.dart';

@immutable
abstract class PublicNotificationState {}

class PublicNotificationInitial extends PublicNotificationState {}


class PublicNotificationLoading extends PublicNotificationState {}
class PublicNotificationSuccess extends PublicNotificationState {}
class PublicNotificationError extends PublicNotificationState {}



class ShowNotificationLoading extends PublicNotificationState {}
class ShowNotificationSuccess extends PublicNotificationState {}
class ShowNotificationError extends PublicNotificationState {}

class SetNotificationLoading extends PublicNotificationState {}
class SetNotificationSuccess extends PublicNotificationState {}
class SetNotificationError extends PublicNotificationState {}
