import 'dart:io';
import 'package:path_provider/path_provider.dart';

// This class for get Storage Path in each mobile and save file to this path

class DirectoryPath {
  static Future<String> getStoragePath() async {
    final Directory? path = await getExternalStorageDirectory();
    if(await path!.exists()) {
      return path.path;
    } else {
      await path.create();
      return path.path;
    }
  }
}