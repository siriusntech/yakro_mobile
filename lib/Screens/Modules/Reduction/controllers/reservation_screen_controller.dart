import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Providers/controllers/reservation_api_controller.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Hotel/path_hotel.dart';

class ReservationScreenController extends GetxController {
  Rx<Color> colorPrimary = ConstColors.alertDanger.obs;
  Rx<Color> colorSecondary = Colors.amber.obs;
  Rx<TextEditingController> nomController = TextEditingController().obs;
  Rx<TextEditingController> prenomController = TextEditingController().obs;
  Rx<TextEditingController> telephoneController = TextEditingController().obs;
  Rx<TextEditingController> nbrChambre = TextEditingController().obs;
  Rx<TextEditingController> totalController = TextEditingController().obs;
  Rx<DateTimeRange> dateRangeController =
      DateTimeRange(start: DateTime.now(), end: DateTime.now()).obs;
  TypeChambreHotel? typeChambreHotel;
  Rx<String> dateArrivee = ''.obs;
  Rx<String> dateDepart = ''.obs;
  RxMap<String, dynamic> datas = <String, dynamic>{}.obs;
  Rx<AuthModel?> authModel = Rx<AuthModel?>(null);
  final AuthController authController = Get.put(AuthController());
  final ReservationApiController reservationApiController =
      Get.put(ReservationApiController());
  final HotelSingleScreenController hotelSingleScreenController =
      Get.find<HotelSingleScreenController>();

  @override
  void onInit() {
    nomController.value = TextEditingController();
    prenomController.value = TextEditingController();
    telephoneController.value = TextEditingController();
    dateRangeController.value =
        DateTimeRange(start: DateTime.now(), end: DateTime.now());
    nbrChambre.value = TextEditingController(text: 0.toString());
    // totalController.value = TextEditingController(text: 0.toString());
    // this.typeChambreHotel = null;
    // getPrix();
    // setNom(authController.authModel.value!.userModel!.nom==null?'':authController.authModel.value!.userModel!.nom!);
    // setPrenom(authController.authModel.value!.userModel!.prenom == null?'':authController.authModel.value!.userModel!.prenom!);
    // setTelephone(authController.authModel.value!.userModel!.contact == null?'':authController.authModel.value!.userModel!.contact!);
    super.onInit();
  }

  Future<void> storeReservation() async {
    Map<String, dynamic> data = {
      'nom': nomController.value.text,
      'prenom': prenomController.value.text,
      'telephone': telephoneController.value.text,
      'date_arrivee': dateArrivee.value,
      'date_depart': dateDepart.value,
      'nbr_chambre': nbrChambre.value.text,
      'id_module': datas['IdModule'],
      'moduleName': datas['Module'],
      'type_chambre_hotel_id': datas['TypeChambreHotel'],
      'reduction': getReduction(),
      'total_a_payer': getTotalaPayer(),
      'total': getTotal(),
      'prix_unitaire': typeChambreHotel!.prix,
    };

    if (data['nom'] == '' ||
        data['prenom'] == '' ||
        data['telephone'] == '' ||
        data['date_arrivee'] == '' ||
        data['date_depart'] == '' ||
        data['nbr_chambre'] == '') {
      Get.snackbar('Erreur', 'Veuillez remplir tous les champs',
          backgroundColor: ConstColors.alertWarnig,
          colorText: Colors.white,
          icon: const Icon(
            Icons.warning,
            color: Colors.white,
          ));
      return;
    }

    return reservationApiController.storeReservation(data);
  }

  @override
  void onReady() {
    super.onReady();
  }

  void setAuthModel(AuthModel? authModel) => this.authModel.value = authModel;

  void setDateRange(DateTimeRange dateRange) {
    dateRangeController.value = dateRange;
    print(dateRange.duration.inDays);
    getTotal();
    dateArrivee.value =
        '${dateRange.end.day}-${dateRange.end.month}-${dateRange.end.year}';
    dateDepart.value =
        '${dateRange.start.day}-${dateRange.start.month}-${dateRange.start.year}';
    update();
  }

  void setNom(String nom) {
    nomController.value.text = nom;
    update();
  }

  void setPrenom(String prenom) {
    prenomController.value.text = prenom;
    update();
  }

  void setTelephone(String telephone) {
    telephoneController.value.text = telephone;
    update();
  }

  void setModuledata(Map<String, dynamic> data) {
    datas.value = data;
    // print(datas);
    update();
  }

  void setChambreHotel(TypeChambreHotel typeChambreHotel) {
    this.typeChambreHotel = typeChambreHotel;
    update();
  }

  double getTotal() {
    getTotalaPayer();
    totalController.value.text = double.parse(
            ((int.parse(typeChambreHotel!.prix.toString()) *
                        int.parse(nbrChambre.value.text)) *
                    dateRangeController.value.duration.inDays)
                .toString())
        .toString();
    // print(totalController.value.text);
    update();
    return double.parse(((int.parse(typeChambreHotel!.prix.toString()) *
                int.parse(nbrChambre.value.text)) *
            dateRangeController.value.duration.inDays)
        .toString());
  }

  double getTotalaPayer() {
    update();
    return dateRangeController.value.duration.inDays == 0
        ? 0.0
        : double.parse(totalController.value.text) -
            (double.parse(totalController.value.text) *
                double.parse(hotelSingleScreenController
                    .hotelModel.value.reduction
                    .toString()) /
                100);
  }

  double getReduction() {
    update();
    return double.parse(
        hotelSingleScreenController.hotelModel.value.reduction.toString());
  }

  @override
  void onClose() {
    super.onClose();
  }

  //Getter
  double get total => getTotal();
}
