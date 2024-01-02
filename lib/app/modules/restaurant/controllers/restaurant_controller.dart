import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Utils/app_constantes.dart';
import '../../../data/repository/data/api_status.dart';
import '../../../data/repository/restaurants_services.dart';
import '../../../models/AffichageHotelRestaurant.dart';
import '../../../models/restaurant_model.dart';
import '../../../models/restaurant_type_model.dart';
import '../../../models/type_annuaire_model.dart';
import '../../../widgets/text_widget.dart';
import '../../home/controllers/home_controller.dart';
import 'package:jaime_yakro/app/models/CommentaireNote.dart';
class RestaurantController extends GetxController {
  var commerceList = List<Restaurant>.empty(growable: true).obs;
  var commerceTypesList = List<RestaurantType>.empty(growable: true).obs;
  var typeAnnuaireList = List<TypeAnnuaireModel>.empty(growable: true).obs;
  var selectedCommerce = Restaurant().obs;
  RxDouble rating = 0.0.obs;
  final restaurantNoteCommentaire = <AffichageHotelRestaurant>[].obs;
  final note = 0.obs;
    final commentaire = TextEditingController().obs;
  final restaurant_id = 0.obs;
  var page = 1;
  var isDataProcessing = false.obs;
  var selectedType = ''.obs;
  var isLoading = true.obs;
  final HomeController homeCtrl = Get.find();

  late TextEditingController searchTextController;

  initFields() async{
    searchTextController  = TextEditingController();
  }

  disposeFields(){
    searchTextController.dispose();
  }

  clearFields(){
    searchTextController.clear();
  }



  // GET ALL COMMERCE
  getCommerces(var page) async{
    try{
      isDataProcessing(true);
      final response = await RestaurantServices.getCommerces();
      if(response is Success){
        isDataProcessing(false);
        commerceList.addAll(response.response as List<Restaurant>);
      }
      if(response is Failure){
        isDataProcessing(false);
        print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      isDataProcessing(false);
      print("Exception  "+ex.toString());
    }
  }
  // GET ALL COMMERCE BY TYPE
  getCommercesByType(var type) async{
    try{

      isDataProcessing(true);
     final response = await RestaurantServices.getCommercesByType(type);
      if(response is Success){
        commerceList.clear();
        isDataProcessing(false);
        commerceList.addAll(response.response as List<Restaurant>);
      }
      if(response is Failure){
        isDataProcessing(false);
        print("Erreur getCommercesByType "+response.errorResponse.toString());
      }
    }catch(ex){
      isDataProcessing(false);
      print("Exception  "+ex.toString());
    }
  }
  // GET ALL COMMERCE BY NAME
  getCommercesByName(var name) async{
    try{
      isDataProcessing(true);
      final response = await RestaurantServices.getCommercesByNom(name);
      if(response is Success){
        commerceList.clear();
        isDataProcessing(false);
        commerceList.addAll(response.response as List<Restaurant>);
      }
      if(response is Failure){
        isDataProcessing(false);
        print("Erreur getCommercesByName "+response.errorResponse.toString());
      }
    }catch(ex){
      isDataProcessing(false);
      print("Exception  "+ex.toString());
    }
  }
  // SET SELECTED COMMERCE
  void setSelectedCommerce(Restaurant commerce){
    selectedCommerce.value = commerce;
  }
  // SET SELECTED TYPE
  void setSelectedType(var type){
    selectedType.value = type;
  }
  // REFRESH PAGE
  refreshData() async{
    if(searchTextController.text == ""){
      commerceList.clear();
      commerceTypesList.clear();
      clearFields();
      setSelectedType('');
       await getCommerceTypes();
      await getCommerces(page);
    }else{
      await getCommercesByName(searchTextController.text);
    }
    await makeCommercesAsRead();
  }

  // GET ALL COMMERCE TYPES
  getCommerceTypes() async{
    try{
      isDataProcessing(true);
      final response = await RestaurantServices.getCommercetypes();
      if(response is Success){
        isDataProcessing(false);
        commerceTypesList.addAll(response.response as List<RestaurantType>);
      }
      if(response is Failure){
        isDataProcessing(false);
        print("Erreur getCommerceTypes "+response.errorResponse.toString());
      }
    }catch(ex){
      isDataProcessing(false);
      print("Exception  "+ex.toString());
    }
  }

  refreshOnly() async{
    commerceList.clear();
    commerceTypesList.clear();
    setSelectedType('');
     await getCommerceTypes();
    await getCommerces(page);
  }

  Future<Null> showAlerte(phoneNumber) async{
    return Get.defaultDialog(
        title: '',
        content: Container(
          child: Column(
            children: [
              TextButton(
                  onPressed: (){
                    Get.back();
                    makePhoneCall('tel:$phoneNumber');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ICON_TELEPHONE, width: 20, height: 20,),
                      SizedBox(width: 3,),
                      TextWidget(text: 'Appeler', fontSize: 16, fontWeight: FontWeight.bold,alignement: TextAlign.center,)
                    ],
                  )
              ),
              TextButton(
                  onPressed: (){
                    Get.back();
                    makeCopieNumber(phoneNumber);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ICON_COPIE, width: 20, height: 20,),
                      SizedBox(width: 3,),
                      TextWidget(text: 'Copier', fontSize: 16, fontWeight: FontWeight.bold, alignement: TextAlign.center)
                    ],
                  )
              ),
            ],
          ),
        ));
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    // final Uri launchUri = Uri(
    //   scheme: 'tel',
    //   path: phoneNumber,
    // );
    // await launch(launchUri.toString());
    await launchUrl(Uri.parse(phoneNumber));
  }

  Future<void> makeCopieNumber(String phoneNumber) async {
    FlutterClipboard.copy(phoneNumber).then(( result ) {
      Get.snackbar('', "Contact Copié dans le presse-papier", snackPosition: SnackPosition.BOTTOM);
    });
  }
  // SHOW SNACKBAR
  showSnackBar(String title, String message, Color bgColor){
    Get.snackbar(title, message, backgroundColor: bgColor,
        snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
  }

  // MAKE ALL AS READS
  makeCommercesAsRead() async{
    try{
      final response = await RestaurantServices.makeCommercesAsRead();
      if(response is Success){
        // refresh();
      }
      if(response is Failure){
        // isDataProcessing(false);
        // print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      // isDataProcessing(false);
      // print("Exception  "+ex.toString());
    }
  }

    Future<void> examen(CommentaireNote noteModel) async {
    isDataProcessing(true);
    await RestaurantServices.examen(noteModel);
    commentaire.value.clear();
    rating.value = 0;
    isDataProcessing(false);
    isLoading.value = false;
  }

  Future<void> afficheNoteCommtaire( int restaurant_id) async {
    isDataProcessing(true);
    try {
        //  print('je veux hotel_id*******: '+hotel_id.toString());
      // Appel à RestaurantServices.afficheNoteCommentaire(hotel_id)
      List< AffichageHotelRestaurant> result = await RestaurantServices.afficheNoteCommentaire(restaurant_id);
    
      // ignore: unnecessary_null_comparison
      if (result != null) {
        // Si tout s'est bien passé, mettez à jour hotelNoteCommentaire.value
        restaurantNoteCommentaire.value = result;
      } else {
        // Gérer les erreurs ici, par exemple, afficher un message d'erreur.
      }
    } catch (e) {
      // Gérer les erreurs d'exception ici, par exemple, afficher un message d'erreur.
    }

    isDataProcessing(false);
    isLoading.value = false;
  }


  @override
  void onInit(){
    super.onInit();
    initFields();
    getCommerces(page);
    getCommerceTypes();
    homeCtrl.getUnReadItemsCounts();
  }
  @override
  void onReady() {
    super.onReady();
  }
  @override
  void onClose() {
    makeCommercesAsRead();
    homeCtrl.getUnReadItemsCounts();
  }
}
