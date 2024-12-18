part of 'user_information_cubit.dart';

@immutable
abstract class UserInformationState {}

class UserInformationInitial extends UserInformationState {}


class LoadingInformationState extends UserInformationState {}
class SuccsessInformationState extends UserInformationState {

}
class ErrorInformationState extends UserInformationState {

}

class LoadingInformationUpdateState extends UserInformationState {}
class SuccessInformationUpdateState extends UserInformationState {}
class ErrorInformationUpdateState extends UserInformationState {}




class NewLoadingInformationState extends UserInformationState {}
class NewSuccessInformationState extends UserInformationState {}
class NewErrorInformationState extends UserInformationState {}



class NewLoadingCvState extends UserInformationState {}
class NewSuccessCvState extends UserInformationState {}
class NewErrorCvState extends UserInformationState {}



class GetProfileImageSuccess extends UserInformationState {}
class GetProfileImageError extends UserInformationState {}

