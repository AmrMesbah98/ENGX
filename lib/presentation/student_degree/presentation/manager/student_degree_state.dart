part of 'student_degree_cubit.dart';

@immutable
sealed class StudentDegreeState {}

final class StudentDegreeInitial extends StudentDegreeState {}
final class GetStudentDegreeLoading extends StudentDegreeState {}
final class GetStudentDegreeSuccess extends StudentDegreeState {}
final class GetStudentDegreeError extends StudentDegreeState {}
