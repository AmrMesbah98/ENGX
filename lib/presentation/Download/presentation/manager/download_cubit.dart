import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../firebase_services/firestore_service.dart';
import '../../data/model.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit(this.firestoreService) : super(DownloadInitial());
  final FireStoreService firestoreService;

  static DownloadCubit get(context) => BlocProvider.of(context);

  bool downloading = false;
  double progress = 0.0;
  String filePath = '';
  String fileName = 'unknown.pdf';
  CancelToken cancelToken = CancelToken();

  List<DownloadModel> downloadModel = [];

  final CollectionReference fileCollection =
      FirebaseFirestore.instance.collection('Downloud');

  Future<void> getFileData() async {
    emit(DownloadLoadingFile());
    firestoreService
        .getCollectionSnapshot(collectionReference: fileCollection)
        .listen((value) {
      downloadModel = [];
      for (var doc in value.docs) {
        downloadModel.add(DownloadModel.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));
      }
      emit(DownloadSuccessFile());
    }).onError((error) {
      emit(DownloadErrorFile());
    });
  }

  // Request storage permission based on Android version
  Future<bool> checkStoragePermission() async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;
    if (android.version.sdkInt < 33) {
      if (await Permission.storage.request().isGranted) {
        return true;
      } else if (await Permission.storage.request().isPermanentlyDenied) {
        await openAppSettings();
      }
    } else {
      if (await Permission.photos.request().isGranted) {
        return true;
      } else if (await Permission.photos.request().isPermanentlyDenied) {
        await openAppSettings();
      }
    }
    return false;
  }

  // Request manage external storage permission for Android 10+
  Future<void> requestManageExternalStoragePermission() async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      print("MANAGE_EXTERNAL_STORAGE permission granted.");
    } else {
      print("MANAGE_EXTERNAL_STORAGE permission denied.");
      if (await Permission.manageExternalStorage.isPermanentlyDenied) {
        openAppSettings();
      }
    }
  }

  // Start download
  Future<void> startDownload(String url, String fileName) async {
    if (!fileName.endsWith('.pdf')) {
      fileName = '$fileName.pdf';
    }
    //===================================================================
    bool hasPermission = await checkStoragePermission();
    if (!hasPermission) {
      emit(DownloadError('Storage permission not granted!'));
      return;
    }

    if (Platform.isAndroid &&
        (await Permission.manageExternalStorage.isGranted == false)) {
      await requestManageExternalStoragePermission();
    }

    // Use public 'Download' folder
    final storePath = '/storage/emulated/0/Download';
    final downloadPath = '$storePath/$fileName';
    final dio = Dio();

    try {
      emit(DownloadLoading(0.0)); // Change state to loading

      await dio.download(url, downloadPath, onReceiveProgress: (count, total) {
        emit(DownloadLoading(
            count / total)); // Update loading state with progress
      }, cancelToken: cancelToken);

      emit(DownloadSuccess(downloadPath)); // On success, emit success state
    } catch (e) {
      emit(DownloadError(
          'Error downloading file: $e')); // On error, emit error state
    }
  }

  // Open file
  Future<void> openFile(String fileName) async {
    final directory = await getExternalStorageDirectory();
    final downloadPath = '${directory?.path}/Download/$fileName';

    final result = await OpenFile.open(downloadPath);
    if (result.type != ResultType.done) {
      emit(DownloadError('Could not open file: $downloadPath'));
    }
  }
}
