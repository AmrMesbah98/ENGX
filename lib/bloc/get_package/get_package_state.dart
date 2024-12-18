part of 'get_package_cubit.dart';

@immutable
abstract class GetPackageState {}

class GetPackageInitial extends GetPackageState {}

class GetPackageLoading extends GetPackageState {}
class GetPackageSuccess extends GetPackageState {
  final List<PackageCourses>packageCourses;
  GetPackageSuccess(this.packageCourses);
}
class GetPackageError extends GetPackageState {
  final String errMessage;
  GetPackageError(this.errMessage);
}
