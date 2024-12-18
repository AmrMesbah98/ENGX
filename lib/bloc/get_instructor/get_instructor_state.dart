part of 'get_instructor_cubit.dart';

@immutable
abstract class GetInstructorState {}

class GetInstructorInitial extends GetInstructorState {}

class GetInstructorLoading extends GetInstructorState {}

class GetInstructorSuccess extends GetInstructorState {
  final List<InstructorModel> instructor;

  GetInstructorSuccess(this.instructor);
}

class GetInstructorFailure extends GetInstructorState {
  final String errMessage;

  GetInstructorFailure(this.errMessage);
}


class GetInstructorRateUserLoading extends GetInstructorState {}
class GetInstructorRateUserSuccess extends GetInstructorState {}
class GetInstructorRateUserError extends GetInstructorState {}
