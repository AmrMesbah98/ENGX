part of 'delete_doc_cubit.dart';

@immutable
abstract class DeleteDocState {}

class DeleteDocInitial extends DeleteDocState {}

class DeleteDocLoading extends DeleteDocState {}
class DeleteDocSuccess extends DeleteDocState {}
class DeleteDocError extends DeleteDocState {}
