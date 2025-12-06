import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class NotificationPermissionHelper {
  NotificationPermissionHelper._();
  static final NotificationPermissionHelper instance = NotificationPermissionHelper._();

  /// Request permission for notifications (Android 13+)
  Future<bool> requestPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.notification.status;

      if (status.isGranted) {
        print("🔔 Notification permission already granted");
        return true;
      }

      if (status.isDenied) {
        final result = await Permission.notification.request();
        print("🔔 Notification permission granted? ${result.isGranted}");
        return result.isGranted;
      }

      if (status.isPermanentlyDenied) {
        print("⚠️ Notification permission permanently denied");
        openAppSettings();
        return false;
      }
    }

    // iOS is automatically handled by flutter_local_notifications
    return true;
  }
}
