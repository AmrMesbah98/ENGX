part of 'supoort_data_cubit.dart';

@immutable
abstract class SupoortDataState {}

class SupportDataInitial extends SupoortDataState {}

class SupoortDataLoading extends SupoortDataState {}
class SupoortDataSuccess extends SupoortDataState {}
class SupoortDataError extends SupoortDataState {}
