part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class GetNewsLoading extends NewsState {}
class GetNewsSuccess extends NewsState {}
class GetNewsError extends NewsState {}

class SetNewsLoading extends NewsState {}
class SetNewsError extends NewsState {}
class SetNewsSuccess extends NewsState {}


class DeleteNewsLoading extends NewsState {}
class DeleteNewsError extends NewsState {}
class DeleteNewsSuccess extends NewsState {}


