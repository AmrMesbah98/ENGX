part of 'cv_control_cubit.dart';

@immutable
abstract class CvControlState {}

class CvControlInitial extends CvControlState {}

class CvControlLoading extends CvControlState {}
class CvControlSuccess extends CvControlState {
  final List<CvModel>cvData;
  CvControlSuccess(this.cvData);
}
class CvControlError extends CvControlState {
  final String errMessage;
  CvControlError(this.errMessage);
}

class LoadingSuccess extends CvControlState {}
class LoadingError extends CvControlState {}





class CvControlLoadingTest extends CvControlState {}
class CvControlSuccessTest extends CvControlState {
  final List<CvModelCV>cvData;
  CvControlSuccessTest(this.cvData);
}

class CvControlErrorTest extends CvControlState {
  final String errMessage;
  CvControlErrorTest(this.errMessage);
}


class CvPersonalLoading extends CvControlState {}
class CvPersonalSuccess extends CvControlState {}
class CvPersonalError extends CvControlState {}


class GetCvPersonalLoading extends CvControlState {}
class GetCvPersonalSuccess extends CvControlState {}
class GetCvPersonalError extends CvControlState {}



