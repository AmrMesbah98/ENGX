part of 'certification_cubit.dart';

@immutable
abstract class CertificationState {}

class CertificationInitial extends CertificationState {}

class CertificationLoading extends CertificationState {}
class CertificationSuccess extends CertificationState {}
class CertificationError extends CertificationState {}


class AcceptCertificationLoading extends CertificationState {}
class AcceptCertificationSuccess extends CertificationState {}
class AcceptCertificationError extends CertificationState {}
