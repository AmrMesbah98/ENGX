part of 'code_update_cubit.dart';

@immutable
abstract class CodeUpdateState {}

class CodeUpdateInitial extends CodeUpdateState {}

class CodeUpdateSuccess extends CodeUpdateState {}
class CodeUpdateLoading extends CodeUpdateState {}
class CodeUpdateError extends CodeUpdateState {}
