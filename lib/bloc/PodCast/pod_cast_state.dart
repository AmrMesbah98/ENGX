part of 'pod_cast_cubit.dart';

@immutable
abstract class PodCastState {}

class PodCastInitial extends PodCastState {}

class PodCastLoading extends PodCastState {}
class PodCastSuccess extends PodCastState {}
class PodCastError extends PodCastState {}
