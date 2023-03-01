import 'package:get/get.dart';

import '../../../data/repository/data/Env.dart';

class ZoomController extends GetxController {

  var image_url = "".obs;

  setImageUrl(String url){
    image_url.value = siteUrl+url;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
