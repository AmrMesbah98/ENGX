part of 'get_work_cubit.dart';

@immutable
abstract class GetWorkState {}

class GetWorkInitial extends GetWorkState {}

class GetJobsLoading extends GetWorkState {}
class GetJobsSuccess extends GetWorkState {}
class GetJobsError extends GetWorkState {}

class GetRequestJobsLoading extends GetWorkState {}
class GetRequestJobsStillLoading extends GetWorkState {}
class GetRequestJobsSuccessLoading extends GetWorkState {}
class GetRequestJobsSuccess extends GetWorkState {}
class GetRequestJobsError extends GetWorkState {}

class GetResponseCvLoading extends GetWorkState {}
class GetResponseCvSuccess extends GetWorkState {}
class GetResponseCvSuccessLength extends GetWorkState {}
class GetResponseCvError extends GetWorkState {}

class SetGetResponseCvLoading extends GetWorkState {}
class SetResponseCvSuccess extends GetWorkState {}
class SetResponseCvError extends GetWorkState {}


class SetJobLoading extends GetWorkState {}
class SetJobSuccess extends GetWorkState {}
class SetJobError extends GetWorkState {}