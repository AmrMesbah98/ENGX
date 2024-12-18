part of 'project_cubit.dart';

@immutable
abstract class ProjectState {}

class ProjectInitial extends ProjectState {}



class GetProjectLoading extends ProjectState {}

class GetProjectSuccess extends ProjectState {
  final List<ProjectModel> project;

  GetProjectSuccess(this.project);
}



class GetProjectFailure extends ProjectState {
  final String errMessage;

  GetProjectFailure(this.errMessage);
}




class SetProjectLoading extends ProjectState {}
class SetProjectSuccess extends ProjectState {}
class SetProjectFailure extends ProjectState {}



class UpdateProjectLoading extends ProjectState {}
class UpdateProjectSuccess extends ProjectState {}
class UpdateProjectFailure extends ProjectState {}



class DeleteProjectLoading extends ProjectState {}
class DeleteProjectSuccess extends ProjectState {}
class DeleteProjectFailure extends ProjectState {}


