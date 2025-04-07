import 'package:get/get.dart';
import 'package:jaime_yakro/Screens/Modules/Notification/path_notification.dart';

class NotificationScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationScreenController>(
        () => NotificationScreenController());
  }
}
