import 'package:permission_handler/permission_handler.dart';

// This class for check if storage permission is Active or In-Active
class CheckPermission {
  static Future<bool> checkStoragePermission() async {
    PermissionStatus isStorageAllow = await Permission.storage.status;
    if(!isStorageAllow.isGranted) {
      await Permission.storage.request();
      if(!isStorageAllow.isGranted) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}