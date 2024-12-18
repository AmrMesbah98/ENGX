part of 'zoom_meeting_cubit.dart';

@immutable
abstract class ZoomMeetingState {}

class ZoomMeetingInitial extends ZoomMeetingState {}

class ZoomVideoLoading extends ZoomMeetingState {}
class ZoomVideoSuccess extends ZoomMeetingState {}
class ZoomVideoError extends ZoomMeetingState {}


class GetInnerZoomMeetingLoading extends ZoomMeetingState {}
class GetInnerZoomMeetingSuccess extends ZoomMeetingState {}
class GetInnerZoomMeetingError extends ZoomMeetingState {}


class InnerQuizLoading extends ZoomMeetingState {}
class InnerQuizSuccess extends ZoomMeetingState {}
class InnerQuizError extends ZoomMeetingState {}

class QuizDegreeLoading extends ZoomMeetingState {}
class QuizDegreeSuccess extends ZoomMeetingState {}
class QuizDegreeError extends ZoomMeetingState {}

class GetQuizDegreeLoading extends ZoomMeetingState {}
class GetQuizDegreeSuccess extends ZoomMeetingState {}
class GetQuizDegreeError extends ZoomMeetingState {}