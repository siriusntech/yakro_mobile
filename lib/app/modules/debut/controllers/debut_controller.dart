import 'package:get/get.dart';

class DebutController extends GetxController {

// the index of the current page
  var activePage = 0.obs;

  void changeActivePage(int p){
    activePage.value = p;
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
