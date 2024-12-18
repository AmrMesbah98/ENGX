part of 'free_courses_cubit.dart';

@immutable
abstract class FreeCoursesState {}

class FreeCoursesInitial extends FreeCoursesState {}

class GetFreeCoursesLoading extends FreeCoursesState {}
class GetFreeCoursesSuccess extends FreeCoursesState {}
class GetFreeCoursesError extends FreeCoursesState {
   String? errMessage;
   GetFreeCoursesError(this.errMessage);
}


class GetInnerFreeCoursesLoading extends FreeCoursesState {}
class GetInnerFreeCoursesSuccess extends FreeCoursesState {}
class GetInnerFreeCoursesError extends FreeCoursesState {}

