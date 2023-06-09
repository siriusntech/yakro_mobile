import 'package:get/get.dart';

import '../controllers/widget_splash_screen_controller.dart';

class WidgetSplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WidgetSplashScreenController>(
      () => WidgetSplashScreenController(),
    );
  }
}
