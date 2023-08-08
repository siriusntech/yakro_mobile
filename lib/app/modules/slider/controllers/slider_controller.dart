
import 'package:get/get.dart';
import '../../../data/repository/data/api_status.dart';
import '../../../data/repository/slider_services.dart';
import '../../../models/slider.dart';
class SliderController extends GetxController {

  var isLoading = false.obs;
  var selectedHotels = SliderModel().obs;
  var isDataProcessing = false.obs;
  var selectedType = ''.obs;
  final count = 0.obs;

  final sliderList =<SliderModel>[].obs;
  var sliderRecup  = ''.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
 
  }

  @override
  void onClose() {
    super.onClose();
  }


   getSliderRecup(recup) async{
     sliderRecup.value = recup;
    update();
  }


  getSliders() async {
    isDataProcessing(true);
    var response = await SliderServices.getSliders();

    if (response is Success) {
      isDataProcessing(false);
      sliderList.addAll(response.response as List<SliderModel>);
      isLoading.value = false;


    } else if (response is Failure) {
      isDataProcessing(false);
      print("Erreur " + response.errorResponse.toString());
      isLoading.value = false;
    }

    isDataProcessing(false);
    isLoading.value = false;
  }





  // REFRESH PAGE
  refreshData() async{
    sliderList.clear();
    await getSliders();
  }


}
