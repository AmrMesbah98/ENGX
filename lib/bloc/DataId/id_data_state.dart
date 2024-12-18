part of 'id_data_cubit.dart';

@immutable
abstract class IdDataState {}

class IdDataInitial extends IdDataState {}

class IdDataLoading extends IdDataState {}
class IdDataSuccess extends IdDataState {}
class IdDataError extends IdDataState {}
