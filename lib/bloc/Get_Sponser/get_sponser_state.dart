part of 'get_sponser_cubit.dart';

@immutable
abstract class GetSponserState {}

class GetSponserInitial extends GetSponserState {}

class GetSponserLoading extends GetSponserState {}

class GetSponserSuccess extends GetSponserState {
  final List<Sponser>sponser;
  GetSponserSuccess(this.sponser);
}

class GetSponserError extends GetSponserState {
  final String errMessage;
  GetSponserError(this.errMessage);
}
