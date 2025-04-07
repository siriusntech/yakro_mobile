import 'package:get/get.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Widgets/path_widget.dart';
import 'package:quickalert/quickalert.dart';

class ReservationApiController extends GetxController {
  final ReservationService _reservationService = ReservationService();
  final MainController mainController = Get.find();
  Rx<ReservationModel?> reservationModel = ReservationModel().obs;
  RxList<ReservationModel?> listReservationModel = <ReservationModel?>[].obs;
  RxBool reservationLoading = false.obs;
  RxBool listeReservationLoading = false.obs;
  RxMap<String, dynamic> data = <String, dynamic>{}.obs;
  @override
  void onInit() {
    _reservationService.onInit();
    mainController.onInit();
    reservationLoading.value = false;
    getReservation();
    super.onInit();
  }

  Future<void> storeReservation(Map<String, dynamic> data) async {
    reservationLoading.value = true;
    try{
      final response = await _reservationService.storeReservation(data);
      reservationModel.value = response.body!;
      reservationLoading.value = false;
    }catch(e){
      reservationLoading.value = false;
    }
  }

  void setModuledata(Map<String, dynamic> data){
    this.data.value = data;
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> getReservation() async {
    listeReservationLoading.value = true;
    try{
      final response = await _reservationService.getReservations();
      print(response.body);
      listReservationModel.value = response.body!;
      listeReservationLoading.value = false;
    }catch(e){
      listeReservationLoading.value = false;
    }
  }

  //Rating Hotel
  void setRating(HotelModel hotelM, double rating) {
    hotelM.moyenneRating.value = double.parse(rating.ceil().toString());
    incrementRating(hotelM);
    // postRatingHotel(rating);
    update();
  }

  //Rating Increment Hotel
  void incrementRating(HotelModel hotelM) {
    if (hotelM.isRating.value == false) {
      hotelM.countRating.value = hotelM.countRating.value + 1;
      hotelM.isRating.value = true;
    }
    update();
  }

  // //add Rating Hotel
  // Future<void> postRatingHotel(double rating) async {
  //   // print("======POST RATING HOTEL=======");
  //   try {
  //     var response = await _reservationService.postRatingHotel(
  //         _mainController.userId.value,
  //         hotelModel.value.id.toString(),
  //         int.parse(rating.ceil().toString()));
  //     if (response.statusCode == 200) {
  //       Get.snackbar(
  //         'Rating',
  //         'Rating Ajouté avec Succès',
  //         backgroundColor: ConstColors.alertSuccess,
  //         colorText: Colors.white,
  //         snackStyle: SnackStyle.FLOATING,
  //         borderRadius: 10,
  //         margin: const EdgeInsets.all(10),
  //         icon: const Icon(
  //           Icons.check_circle,
  //           color: Colors.white,
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void onClose() {
    super.onClose();
  }
}