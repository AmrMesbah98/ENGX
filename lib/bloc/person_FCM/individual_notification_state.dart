part of 'individual_notification_cubit.dart';

@immutable
abstract class IndividualNotificationState {}

class IndividualNotificationInitial extends IndividualNotificationState {}

class IndividualNotificationLoading extends IndividualNotificationState {}
class IndividualNotificationSuccess extends IndividualNotificationState {}
class IndividualNotificationError extends IndividualNotificationState {}
