part of 'shorts_cubit.dart';

@immutable
sealed class ShortsState {}

final class ShortsInitial extends ShortsState {}
final class GetShortsVideosLoading extends ShortsState {}
final class GetShortsVideosSuccess extends ShortsState {}
final class GetShortsVideosError extends ShortsState {}