import 'dart:io';

import 'package:download_file_from_server/rest_api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'directory_path.dart';


class MyProvider with ChangeNotifier {

  bool _downloading = false;
  bool get downloading => _downloading;

  bool _fileExists = false;
  bool get fileExists => _fileExists;

  double _progressIndicatorValue = 0.0;
  double get progressIndicatorValue => _progressIndicatorValue;

  Future<void> startDownloading(String fileName, String url) async {
    _downloading = true;
    String storagePath = await DirectoryPath.getStoragePath();
    File filePath = File('$storagePath/$fileName');

    try {
      http.StreamedResponse response = await RestApiServices.getFile(url);
      final int? contentLength = response.contentLength;
      List<int> bytes = [];
      response.stream.listen((thisone) {
        bytes.addAll(thisone);
        final int downloadedLength = bytes.length;
        _progressIndicatorValue = downloadedLength / contentLength!;
        notifyListeners();
      }, onDone: () async {
        await filePath.writeAsBytes(bytes);
        _downloading = false;
        _fileExists = true;
        notifyListeners();
      }, onError: (e) {
        print('error is $e');
      }, cancelOnError: true);
    } catch(e) {
      print('try catch -> error is $e');
    }



    notifyListeners();

  }


  Future<void> checkFileExists(String fileName) async {
    String storagePath = await DirectoryPath.getStoragePath();
    String filePath = '$storagePath/$fileName';
    _fileExists = await File(filePath).exists();
    notifyListeners();
  }






}
