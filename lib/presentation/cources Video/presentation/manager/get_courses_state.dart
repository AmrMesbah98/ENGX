part of 'get_courses_cubit.dart';

@immutable
abstract class CoursesState {}

class GetCoursesInitial extends CoursesState {}

class GetCoursesLoading extends CoursesState {}
class GetCoursesSuccess extends CoursesState {}
class GetCoursesFailure extends CoursesState {}


class GetInnerCategoryLoading extends CoursesState {}
class GetInnerCategorySuccess extends CoursesState {}
class GetInnerCategoryError extends CoursesState {}

class SetPromoCodeLoading extends CoursesState {}
class SetPromoCodeSuccess extends CoursesState {}
class SetPromoCodeError extends CoursesState {}


