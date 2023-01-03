import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mon_plateau/app/modules/alerte/alerte_model.dart';
import 'package:mon_plateau/app/widgets/text_widget.dart';

import '../../../Utils/app_routes.dart';
import '../../../data/repository/alerte_services.dart';
import '../../../data/repository/data/api_status.dart';
import '../../../data/repository/reponse_services.dart';
import '../../../widgets/alerte_widgets.dart';
import '../alerte_type_model.dart';

class AlerteController extends GetxController {

  var user_id = 0.obs;

  var type_alertes_list = List<AlerteType>.empty(growable: true).obs;
  var alerteList = List<Alerte>.empty(growable: true).obs;
  var allAlerteList = List<Alerte>.empty(growable: true).obs;

  var selectedTypeAlerteModel = AlerteType().obs;
  var selectedAlerte = Alerte().obs;
  var selected_type_alerte = ''.obs;
  var dropdown_selected_type_alerte = 'Autre'.obs;

  var isDataProcessing = false.obs;
  var isAllDataProcessing = false.obs;
  var isProcessing = false.obs;

  var addFormIsValid = false.obs;
  var editFormIsValid = false.obs;

  final form_key = GlobalKey<FormState>();
  final edit_form_key = GlobalKey<FormState>();
  // final scaffold_key = GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();

  var date_to_DB = ''.obs;

  late TextEditingController txtLocalisationController, txtDateController, txtDescriptionController;

  var fileUrl = ''.obs;
  var loading = false.obs;
  var addFile = false.obs;
  var enabledBtnSend = false.obs;

  var isVideo = false.obs;
  var filePicked = ''.obs;

  var imageFile = File('').obs;
  var videoFile = File('').obs;
  final picker = ImagePicker();


  Future pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80, maxHeight: 500);
    if (pickedFile == null) return;

    fileUrl.value = pickedFile.path;
    isVideo.value = false;
    filePicked.value = 'image';
    imageFile.value = File(pickedFile.path);
    addFile.value = false;
  }

  Future pickVideo(ImageSource source) async {
    final pickedFile = await picker.pickVideo(source: source, maxDuration: Duration(seconds: 35));
    if (pickedFile == null) return;
    if (GetUtils.isVideo(pickedFile.path)){
      showSnackBar('Type de fichier inconnu', "Veuillez choisir une video svp", Colors.red);
      return;
    }

    fileUrl.value = pickedFile.path;
    isVideo.value = true;
    filePicked.value = 'video';
    videoFile.value = File(pickedFile.path);
    addFile.value = false;
  }

  void choosePhoto(BuildContext ctx) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        context: ctx,
        builder: (ctx) => Container(
          width: double.infinity,
          height: 100,
          color: Colors.white,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(ctx).size.width / 2 - 35,
                height: 45,
                child: ElevatedButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                    Get.back();
                  },
                  icon: Icon(
                    Icons.add_photo_alternate_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                  label: TextWidget(
                    text: "Galérie",
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(ctx).size.width / 2 - 35,
                height: 45,
                child: ElevatedButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.camera);
                    Get.back();
                  },
                  icon: Icon(
                    Icons.add_a_photo_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  label: TextWidget(
                    text: "Caméra",
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                ),
              ),
            ],
          ),
        ));
  }

  void chooseVideo(BuildContext ctx) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        context: ctx,
        builder: (ctx) => Container(
          width: double.infinity,
          height: 100,
          color: Colors.white,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(ctx).size.width / 2 - 35,
                height: 45,
                child: ElevatedButton.icon(
                  onPressed: () {
                    pickVideo(ImageSource.gallery);
                    Get.back();
                  },
                  icon: Icon(
                    Icons.add_photo_alternate_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                  label: TextWidget(
                    text: "Galérie",
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(ctx).size.width / 2 - 35,
                height: 45,
                child: ElevatedButton.icon(
                  onPressed: () {
                    pickVideo(ImageSource.camera);
                    Get.back();
                  },
                  icon: Icon(
                    Icons.add_a_photo_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  label: TextWidget(
                    text: "Caméra",
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                ),
              ),
            ],
          ),
        ));
  }

  getTypeAlertes() async {
    try{
      isDataProcessing(true);
      final response = await AlerteServices.getTypeAlertes();
      if(response is Success){
        type_alertes_list.clear();
        type_alertes_list.addAll(response.response as List<AlerteType>);
      }
      if(response is Failure){
        isDataProcessing(false);
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      isDataProcessing(false);
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  getAlertes() async {
    try{
      isDataProcessing(true);
      final response = await AlerteServices.getAlertes();
      if(response is Success){
        isDataProcessing(false);
        alerteList.addAll(response.response as List<Alerte>);
      }
      if(response is Failure){
        isDataProcessing(false);
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      isDataProcessing(false);
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  getMyAlertesByType() async {
    try{
      isDataProcessing(true);
      final response = await AlerteServices.getMyAlertesByType(selectedTypeAlerteModel.value.id);
      if(response is Success){
        isDataProcessing(false);
        alerteList.clear();
        alerteList.addAll(response.response as List<Alerte>);
      }
      if(response is Failure){
        isDataProcessing(false);
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      isDataProcessing(false);
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  getAllAlertes() async {
    try{
      isAllDataProcessing(true);
      final response = await AlerteServices.getAllAlertes();
      if(response is Success){
        isAllDataProcessing(false);
        allAlerteList.clear();
        allAlerteList.addAll(response.response as List<Alerte>);
      }
      if(response is Failure){
        isAllDataProcessing(false);
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      isAllDataProcessing(false);
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  getAllAlertesByType() async {
    try{
      isDataProcessing(true);
      final response = await AlerteServices.getAllAlertesByType(selectedTypeAlerteModel.value.id);
      if(response is Success){
        isDataProcessing(false);
        allAlerteList.clear();
        allAlerteList.addAll(response.response as List<Alerte>);
      }
      if(response is Failure){
        isDataProcessing(false);
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      isDataProcessing(false);
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  createAlerte(data) async {
    try{
      isProcessing(true);
      final response = await AlerteServices.createAlerte(data);
      if(response is Success){
        isProcessing(false);
        clearFields();
        removeFile();
        refresh();
        Get.toNamed(AppRoutes.ALERTE);
      }
      if(response is Failure){
        isProcessing(false);
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      isProcessing(false);
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  setSelectedAlerte(Alerte alerte){
     selectedAlerte.value = alerte;
  }

  setSelectedTypeAlerte(AlerteType type){
    selectedTypeAlerteModel.value = type;
    selected_type_alerte.value = selectedTypeAlerteModel.value.nom!;
  }
  // GO TO EDIT PAGE
  void goToEditPage(){
    txtLocalisationController.text = selectedAlerte.value.localisation!;
    txtDateController.text = selectedAlerte.value.dateIncident!;
    txtDescriptionController.text = selectedAlerte.value.description!;

    var typeAlerte = type_alertes_list.firstWhere((element) => element.id == selectedAlerte.value.typeId);
    setSelectedTypeAlerte(typeAlerte);
    Get.toNamed(AppRoutes.EDIT_ALERTE);
  }
  updateAlerte(alt_id, data) async {
    try{
      isProcessing(true);
      final response = await AlerteServices.updateAlerte(alt_id, data);
      if(response is Success){
        isProcessing(false);
        clearFields();
        removeFile();
        refresh();
        Get.toNamed(AppRoutes.ALERTE);
      }
      if(response is Failure){
        isProcessing(false);
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      isProcessing(false);
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }
  // DEL CONFIRLMATION
  void confirmDelete(alt_id){
    Get.defaultDialog(
        title: 'Confirmation',
        titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        middleText: 'Voulez-vous supprimer cette alerte ?' ,
        middleTextStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.all(5.0),
        textConfirm: 'Confirmer',
        confirmTextColor: Colors.white,
        textCancel: 'Annuler',
        cancelTextColor: Colors.red,
        onConfirm: (){
          deleteAlerte(alt_id);
        }
    );
  }

  deleteAlerte(id) async {
    try{
      isProcessing(true);
      final response = await AlerteServices.deleteAlerte(id);
      if(response is Success){
        isProcessing(false);
        refresh();
        Get.toNamed(AppRoutes.ALERTE);
      }
      if(response is Failure){
        isProcessing(false);
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      isProcessing(false);
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  likeAlerte(alerte_id) async {
    try{
      final response = await AlerteServices.likeAlerte(alerte_id);
      if(response is Success){
        final alerte_index = allAlerteList.indexWhere((element) => element.id == alerte_id);
        final _alerte = allAlerteList[alerte_index];
        manageLike(_alerte, alerte_index);
      }
      if(response is Failure){
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  manageLike(Alerte alerte, index) async{
    if(alerte.id != null){
      if(alerte.liked == 2){
        alerte.unLikeCount! > 0 ? alerte.unLikeCount = alerte.unLikeCount! - 1 : alerte.unLikeCount = 0;
      }
      alerte.liked = 1;
      alerte.likeCount = alerte.likeCount! + 1;

      allAlerteList.replaceRange(index, index+1, [alerte]);
      alerteList.replaceRange(index, index+1, [alerte]);
      selectedAlerte.value = Alerte();
      selectedAlerte.value = allAlerteList[index] == alerte ? allAlerteList[index] : alerteList[index];

    }
  }

  unLikeAlerte(alerte_id) async {
    try{
      final response = await AlerteServices.unLikeAlerte(alerte_id);
      if(response is Success){
        final alerte_index = allAlerteList.indexWhere((element) => element.id == alerte_id);
        final _alerte = allAlerteList[alerte_index];
        manageUnlike(_alerte, alerte_index);
      }
      if(response is Failure){
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  manageUnlike(Alerte alerte, index) async{
    if(alerte.liked == 1){
      alerte.likeCount! > 0 ? alerte.likeCount = alerte.likeCount! - 1 : alerte.likeCount = 0;
    }
    alerte.liked = 2;
    alerte.unLikeCount = alerte.unLikeCount! + 1;

    allAlerteList.replaceRange(index, index+1, [alerte]);
    alerteList.replaceRange(index, index+1, [alerte]);
    selectedAlerte.value = Alerte();
    selectedAlerte.value = allAlerteList[index] == alerte ? allAlerteList[index] : alerteList[index];
  }

  likeAlerteReponse(alerte_id, reponse_id) async {
    try{
      var response = await ReponseServices.likeReponse(reponse_id);
      if(response is Success){
        final alerte_index = alerteList.indexWhere((element) => element.id == alerte_id);
        final reponse = alerteList[alerte_index].reponse;
        if(reponse?.liked==2 || reponse?.liked==0){
          reponse!.un_like > 0 ? reponse.un_like = reponse.un_like - 1 : reponse.un_like = 0;
        }
        reponse?.liked = 1;
        reponse?.like = reponse.like + 1;
      }
      if(response is Failure){
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  unLikeAlerteReponse(alerte_id, reponse_id) async {
    try{
      var response = await ReponseServices.unLikeReponse(reponse_id);
      if(response is Success){
        final alerte_index = alerteList.indexWhere((element) => element.id == alerte_id);
        final reponse = alerteList[alerte_index].reponse;
        if(reponse?.liked==1 || reponse?.liked==0){
          reponse!.like > 0 ? reponse.like = reponse.like - 1 : reponse.like = 0;
        }
        reponse?.liked = 2;
        reponse?.un_like = reponse.un_like + 1;
      }
      if(response is Failure){
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      showSnackBar("Exception", ex.toString(), Colors.red);
    }

  }

  createDropDownList(){
    print(type_alertes_list.length.toString());
    return type_alertes_list.length > 0 ? DropdownButton(
      hint: Text("Choisissez la nature de l'incident"),
      style: TextStyle(fontSize: 15.0, color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      value: dropdown_selected_type_alerte.value,
      onChanged: (newValue){
        var typeAlt = type_alertes_list.firstWhere((typeAlt) => typeAlt.nom == newValue);
        selectedTypeAlerteModel.value = typeAlt;
        selected_type_alerte.value = newValue.toString();
        dropdown_selected_type_alerte.value = newValue.toString();
        Get.toNamed(AppRoutes.ADD_ALERTE);
        // Navigator.pushNamed(context, 'new_alerte');
      },
      items: type_alertes_list.map<DropdownMenuItem<String>>((value){
        return DropdownMenuItem<String>(
          value: value.nom,
          child: Text(value.nom!),
        );
      }).toList(),
      elevation: 0,
    ) : Container(child: TextWidget(text: 'Aucun type trouvé', fontWeight: FontWeight.bold, color: Colors.red,),);
    // ignore: dead_code
  }

  // REFRESH PAGE
  void refresh(){
    alerteList.clear();
    allAlerteList.clear();
    type_alertes_list.clear();
    selected_type_alerte.value = '';
    
    getTypeAlertes();
    getAlertes();
    getAllAlertes();
  }

  initFields() async{
    SharedPreferences storage = await SharedPreferences.getInstance();
    user_id.value = storage.getInt('user_id') ?? 0;

    txtLocalisationController = TextEditingController();
    txtDateController = TextEditingController();
    txtDescriptionController = TextEditingController();
  }
  disposeFields(){
    txtLocalisationController.dispose();
    txtDateController.dispose();
    txtDescriptionController.dispose();
  }
  clearFields(){
    txtLocalisationController.clear();
    txtDateController.clear();
    txtDescriptionController.clear();
  }
  removeFile(){
    fileUrl.value = '';
    isVideo.value = false;
    filePicked.value = '';
    addFile.value = false;
  }


  // MAKE ALL AS READS
  makeAlertesAsRead() async{
    try{
      final response = await AlerteServices.makeAlertesAsRead();
      if(response is Success){
        // refresh();
      }
      if(response is Failure){
        // isDataProcessing(false);
        // showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      // isDataProcessing(false);
      // showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  @override
  void onInit() {
    super.onInit();
    refresh();
    initFields();

    makeAlertesAsRead();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    removeFile();
    disposeFields();

    makeAlertesAsRead();
  }

  selectDateTime(BuildContext context) async{
    await DatePicker.showDateTimePicker(context,
      showTitleActions: true,
      minTime: DateTime(selectedDate.year, selectedDate.month-1, selectedDate.day-6),
      maxTime: DateTime(selectedDate.year+1, selectedDate.month+1, selectedDate.day+6),
      theme: DatePickerTheme(
        headerColor: Colors.blue,
        backgroundColor: Colors.black54,
        itemStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18),
        doneStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        cancelStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onChanged: (date) {
        // DateFormat format = DateFormat("yyyy-MM-dd hh:mm");
        // _dateController.text = format.format(date).toString();
      },
      onConfirm: (date) {
        DateFormat format = DateFormat("yyyy-MM-dd H:mm");
        DateFormat format2 = DateFormat("dd-MM-yyyy H:mm");
        txtDateController.text = format2.format(date).toString();
        date_to_DB.value = format.format(date).toString();
      },
      currentTime: selectedDate,
      locale: LocaleType.fr,
    );
  }

  String? validLocalisation(value){
    if (value == null || value.isEmpty)
      return "Entrer le Lieu";
    if (value.length < 2)
      return "Lieu de l'incident trop court(Au moins 2 caractères)";
    if (value.length > 200)
      return "Lieu de l'incident trop long(Au plus 250 caractères)";
    return null;
  }
  String? validDescription(value){
    if (value == null || value.isEmpty)
      return "Entrer une description pour nous faciliter la tâche svp";
    if (value.length < 2)
      return "Description trop courte(Au moins 2 caractères)";
    // if (value.length > 300)
    //   return "Description trop longue(Au plus 300 caractères)";
    return null;
  }
  void checkForm(){
    addFormIsValid(false);
    final isValid = form_key.currentState!.validate();
    if(!isValid){
      addFormIsValid(false);
      return ;
    }
    form_key.currentState!.save();
    addFormIsValid(true);
  }
  void checkEditForm(){
    editFormIsValid(false);
    final isValid = edit_form_key.currentState!.validate();
    if(!isValid){
      editFormIsValid(false);
      return ;
    }
    edit_form_key.currentState!.save();
    editFormIsValid(true);
  }

}
