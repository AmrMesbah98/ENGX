part of 'post_cubit.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class GetPostLoading extends PostState {}
class GetPostSuccess extends PostState {}
class GetPostError extends PostState {}


class SetPostLoading extends PostState {}
class SetPostSuccess extends PostState {}
class SetPostError extends PostState {}
