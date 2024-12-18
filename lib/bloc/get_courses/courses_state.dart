part of 'courses_cubit.dart';

@immutable
abstract class CoursesState {}

class CoursesInitial extends CoursesState {}


class GetCoursesLoading extends CoursesState{}


class GetCoursesSuccess extends CoursesState{
  final List<CoursesModel>courses;
  GetCoursesSuccess(this.courses);
}

class GetCoursesFailure extends CoursesState{
  final String errMessage;
  GetCoursesFailure(this.errMessage);
}


class CoursesDeleteLoading extends CoursesState {}
class CoursesDeleteSuccess extends CoursesState {}
class CoursesDeleteError extends CoursesState {}





class UpdateCoursesLoading extends CoursesState{}
class UpdateCoursesSuccess extends CoursesState{}
class UpdateCoursesFailure extends CoursesState{
  final String errMessage;
  UpdateCoursesFailure(this.errMessage);
}
