part of 'download_cubit.dart';

abstract class DownloadState {}

class DownloadInitial extends DownloadState {}

class DownloadLoading extends DownloadState {
  final double progress;
  DownloadLoading(this.progress);
}

class DownloadSuccess extends DownloadState {
  final String filePath;
  DownloadSuccess(this.filePath);
}

class DownloadError extends DownloadState {
  final String errorMessage;
  DownloadError(this.errorMessage);
}

class DownloadLoadingFile extends DownloadState {}

class DownloadSuccessFile extends DownloadState {}

class DownloadErrorFile extends DownloadState {}
