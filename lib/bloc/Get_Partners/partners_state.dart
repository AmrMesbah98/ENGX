part of 'partners_cubit.dart';

@immutable
abstract class PartnersState {}

class PartnersInitial extends PartnersState {}

class PartnersLoading extends PartnersState {}
class PartnersSuccess extends PartnersState {
  final List<Partners>partners;
  PartnersSuccess(this.partners);
}
class PartnersError extends PartnersState {
  final String errMessage;
  PartnersError(this.errMessage);
}
