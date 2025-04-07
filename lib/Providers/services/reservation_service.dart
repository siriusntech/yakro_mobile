import 'package:get/get.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Config/app_config.dart';

import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Widgets/path_widget.dart';
import 'package:quickalert/models/quickalert_type.dart';

class ReservationService extends GetConnect{
  final MainController mainController = Get.put(MainController());

  @override
  void onInit() {
    mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    super.onInit();
  }


  Future <Response<ReservationModel>> storeReservation(Map<String, dynamic> data) async {
    // print(data);
    return post('/reservations-client/store', data, headers: mainController.getLoggedHeaders(), decoder: (data){
      if(data['success'] == true){
        Get.back();
        Get.back();
        quickAlertDialog(Get.context!, QuickAlertType.success, color: ConstColors.vertColorFonce, message: "Reservation Effectué", title: "Success", onConfirmBtnTap: () => Get.back());
      }else{
        quickAlertDialog(Get.context!, QuickAlertType.error, color: ConstColors.alertDanger, message: "Reservation Echoué", title: "Erreur", onConfirmBtnTap: () => Get.back());
      }
      return ReservationModel.fromJson(data['data']);
    }).catchError((e){
      print(e);
    });
  }

  Future <Response<List<ReservationModel>>> getReservations() async {
    return get(
        '/reservations-client', headers: mainController.getLoggedHeaders(),
        decoder: (data) =>
        List<ReservationModel>.from(
            data['data'].map((x) => ReservationModel.fromJson(x))));
  }

  Future <Response<ReservationModel>> updateNoteSejour(Map<String, dynamic> data) async {
    return post(
        '/reservations-client/update-note-sejour', data, headers: mainController.getLoggedHeaders(),
        decoder: (data) =>ReservationModel.fromJson(data['data']));
  }




}