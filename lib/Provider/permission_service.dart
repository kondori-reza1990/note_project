import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    if (statuses.values.elementAt(0) == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<bool> requestPermission({Function? onPermissionDenied}) async {
    var granted = await _requestPermission();
    if (!granted) {
      onPermissionDenied!();
    }
    return granted;
  }

  Future<bool> hasPhonePermission() async {
    return hasPermission(Permission.phone);
  }

  Future<bool> hasStoragePermission() async {
    return hasPermission(Permission.storage);
  }

  Future<bool> hasPermission(Permission permission) async {
    return await permission.request().isGranted;
  }
}
