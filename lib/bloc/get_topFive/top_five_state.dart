part of 'top_five_cubit.dart';

@immutable
abstract class TopFiveState {}

class TopFiveInitial extends TopFiveState {}

class LoadingTopFiveState extends TopFiveState {}
class SuccessTopFiveState extends TopFiveState {
  final List<TopFiveModel> TopFiveCharacter;

  SuccessTopFiveState(this.TopFiveCharacter);

}
class ErrorTopFiveState extends TopFiveState {
  final String errMessage;

  ErrorTopFiveState(this.errMessage);
}

