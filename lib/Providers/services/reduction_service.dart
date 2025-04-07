import 'package:get/get.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Screens/Widgets/path_widget.dart';
import 'package:quickalert/models/quickalert_type.dart';

import '../path_providers.dart';

class ReductionService extends GetConnect {
  final MainController mainController = Get.find<MainController>();

  @override
  void onInit() {
    mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    super.onInit();
  }

  Future<Response<Map<String, dynamic>>> addReduction(Map<String, dynamic> data) async {return post('/reductions-client/store', data, headers: mainController.getLoggedHeaders(), decoder: (data){
    print(data);
    return data;
  });}

  Future <Response<HotelModel>> checkHotel(String hotelCode)  async {
    // print('=====================$hotelCode CHECH HOTEL');
    return post('/hotel-check',{'hotel_code': hotelCode}, headers: mainController.getLoggedHeaders(), decoder: (data){
      // print(data);
      return HotelModel.fromJson(data['data']);
    });
  }

  Future <Response<Map<String, dynamic>>> changeReservations(String hotelCode)  async {
    return post('/reservattion-status',{}, headers: mainController.getLoggedHeaders(), decoder: (data){
      if(data['success'] == true){
        // Get.back();
        // Get.back();
        quickAlertDialog(Get.context!, QuickAlertType.success, color: ConstColors.vertColorFonce, message: "Reduction Effectué", title: "Success", onConfirmBtnTap: () => Get.back());
      }else{
        quickAlertDialog(Get.context!, QuickAlertType.error, color: ConstColors.alertDanger, message: "Reduction Echoué", title: "Erreur", onConfirmBtnTap: () => Get.back());
      }
      return data;
    });
  }
}