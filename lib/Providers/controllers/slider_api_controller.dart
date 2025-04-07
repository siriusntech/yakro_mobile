import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class SliderApiController extends GetxController {
  final MainController mainController = Get.put(MainController());
  final SliderService _sliderService = SliderService();
  final RxList<SliderModel> sliderList = <SliderModel>[].obs;
  final RxBool sliderLoading = false.obs;

  @override
  void onInit() {
    mainController.onInit();
    // print('==============INIT SLIDER==============');
    // print(mainController.getLoggedHeaders());

    _sliderService.onInit();
    getAllSlider();
    super.onInit();
  }

  //get all sliders
  Future<void> getAllSlider() async {
    // print("==============GET ALL SLIDER CONTROLLER==============");
    // print(mainController.getLoggedHeaders());
    sliderLoading.value = true;
    try {
      final response = await _sliderService.getAllSlider();
      // print(response.body);
      if (response.statusCode == 200) {
        sliderList.value = response.body!;
        sliderLoading.value = false;
      } else {
        sliderLoading.value = false;
      }
    } catch (e) {
      sliderLoading.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
