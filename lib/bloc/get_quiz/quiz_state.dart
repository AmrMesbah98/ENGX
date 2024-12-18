part of 'quiz_cubit.dart';

@immutable
abstract class QuizState {}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}
class QuizSuccess extends QuizState {}
class QuizError extends QuizState {}

class QuizDegreeLoading extends QuizState {}
class QuizDegreeSuccess extends QuizState {}
class QuizDegreeError extends QuizState {}

class GetQuizDegreeLoading extends QuizState {}
class GetQuizDegreeSuccess extends QuizState {}
class GetQuizDegreeError extends QuizState {}


