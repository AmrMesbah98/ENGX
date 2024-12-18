part of 'dash_board_student_cubit.dart';

@immutable
abstract class DashBoardStudentState {}

class DashBoardStudentInitial extends DashBoardStudentState {}

class DashBoardStudentLoading extends DashBoardStudentState {}

class DashBoardStudentSuccess extends DashBoardStudentState {}

class GetNameInstructorInitial extends DashBoardStudentState {}

class GetNameInstructorLoading extends DashBoardStudentState {}

class GetNameInstructorSuccess extends DashBoardStudentState {}

class GetNameInstructorError extends DashBoardStudentState {}

class DashBoardStudentError extends DashBoardStudentState {}

class DashBoardStudentLoadingInner extends DashBoardStudentState {}

class DashBoardStudentSuccessInner extends DashBoardStudentState {}

class DashBoardStudentErrorInner extends DashBoardStudentState {}

class DashBoardStudentLoadingInnerNew extends DashBoardStudentState {}

class DashBoardStudentSuccessInnerNew extends DashBoardStudentState {}

class DashBoardStudentErrorInnerNew extends DashBoardStudentState {}

class DashBoardStudentLoadingReview extends DashBoardStudentState {}

class DashBoardStudentSuccessReview extends DashBoardStudentState {}

class DashBoardStudentErrorReview extends DashBoardStudentState {}

class DashBoardStudentLoadingReviewFilter extends DashBoardStudentState {}

class DashBoardStudentSuccessReviewFilter extends DashBoardStudentState {}

class DashBoardStudentErrorReviewFilter extends DashBoardStudentState {}
