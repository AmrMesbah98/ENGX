part of 'bloc_cubit.dart';

@immutable
abstract class cubitState {}

class BlocInitial extends cubitState {}

class loadingState extends cubitState {}
class successStateAr extends cubitState {}
class successStateEn extends cubitState {}
class ErrorState extends cubitState {
  final String error;

  ErrorState(this.error);
}

class chachstate extends cubitState {}
class ShopChangePaswwordSuccessState extends cubitState {}

