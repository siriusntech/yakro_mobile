import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_cocody/app/Utils/app_routes.dart';

import '../../../data/repository/data/api_status.dart';
import '../../../data/repository/message_services.dart';
import '../../../widgets/text_widget.dart';
import '../message_model.dart';
import '../message_type_model.dart';

import 'package:image_picker/image_picker.dart';

class MessageController extends GetxController {

  var messageList = List<Message>.empty(growable: true).obs;
  var allMessageList = List<Message>.empty(growable: true).obs;
  var menuMessageTypesList = List<MessageType>.empty(growable: true).obs;
  var myMessagesTypesList = List<MessageType>.empty(growable: true).obs;
  var allMessagesTypesList = List<MessageType>.empty(growable: true).obs;

  var selectedMessage = Message().obs;
  var page = 1;
  var isDataProcessing = false.obs;
  var isAllDataProcessing = false.obs;
  var isProcessing = false.obs;
  var addFormIsValid = false.obs;
  var editFormIsValid = false.obs;
  var selectedType = ''.obs;
  var selectedMessageType = MessageType().obs;

  final form_key = GlobalKey<FormState>();
  final edit_form_key = GlobalKey<FormState>();

  // final scaffold_key = GlobalKey<ScaffoldState>();

  late TextEditingController txtLibelleController, txtDescriptionController, txtNomController;
  late TextEditingController txtPrenomController, txtEmailController, txtContactController;

  var fileUrl = ''.obs;
  // var loading = false.obs;
  var addFile = false.obs;
  var enabledBtnSend = false.obs;

  var isVideo = false.obs;
  var filePicked = ''.obs;

  var imageFile = File('').obs;
  var videoFile = File('').obs;
  final picker = ImagePicker();

  removeFile(){
    fileUrl.value = '';
    isVideo.value = false;
    filePicked.value = '';
    addFile.value = false;
  }

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

  // GET MY MESSAGES
  getMessages(var page) async {
    try{
      isDataProcessing(true);
      final response = await MessageServices.getMessages();
      if(response is Success){
        isDataProcessing(false);
        messageList.addAll(response.response as List<Message>);
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
  // GET MY MESSAGES BY TYPE
  getMyMessagesByType(typeId) async {
    try{
      isDataProcessing(true);
      final response = await MessageServices.getMessagesByType(typeId);
      if(response is Success){
        messageList.clear();
        isDataProcessing(false);
        messageList.addAll(response.response as List<Message>);
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
  // GET ALL MESSAGES
  getAllMessages() async {
    try{
      isAllDataProcessing(true);
      final response = await MessageServices.getAllMessages();
      if(response is Success){
        isAllDataProcessing(false);
        allMessageList.addAll(response.response as List<Message>);
      }
      if(response is Failure){
        isAllDataProcessing(false);
        print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      isAllDataProcessing(false);
      print("Exception  "+ex.toString());
    }
  }
  // GET ALL MESSAGES BY TYPE
  getMessagesByType(typeId) async {
    try{
      isAllDataProcessing(true);
      final response = await MessageServices.getMessagesByType(typeId);
      if(response is Success){
        allMessageList.clear();
        isAllDataProcessing(false);
        allMessageList.addAll(response.response as List<Message>);
      }
      if(response is Failure){
        isAllDataProcessing(false);
        print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      isAllDataProcessing(false);
      print("Exception  "+ex.toString());
    }
  }
  // GET MESSAGE TYPES
  getMessageTypes() async {
    try{
      final response = await MessageServices.getMessageTypes();
      if(response is Success){
        menuMessageTypesList.addAll(response.response as List<MessageType>);
        myMessagesTypesList.addAll(response.response as List<MessageType>);

        allMessagesTypesList.addAll(response.response as List<MessageType>);
        allMessagesTypesList.removeWhere((element) => element.nom.toString().contains('Rendez-vous'));
      }
      if(response is Failure){
        print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      print("Exception  "+ex.toString());
    }
  }
  // CREATE NEW MESSAGE
  createMessage(data) async {
    try{
      isProcessing(true);
      final response = await MessageServices.createMessage(data);
      if(response is Success){
        isProcessing(false);
        refresh();
        // messageList.addAll(response.response as List<Message>);
        Get.toNamed(AppRoutes.MESSAGE);
      }
      if(response is Failure){
        isProcessing(false);
        print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      isProcessing(false);
      print("Exception  "+ex.toString());
    }
  }
  // GO TO EDIT PAGE
  void goToEditPage(){
    txtLibelleController.text = selectedMessage.value.libelle!;
    txtDescriptionController.text = selectedMessage.value.description!;
    selectedMessageType.value = allMessagesTypesList.firstWhere((element) => element.id == selectedMessage.value.typeId);
  }
  // UPDATE MESSAGE
  updateMessage(msg_id, data) async {
    try{
      isProcessing(true);
      final response = await MessageServices.updateMessage(msg_id, data);
      if(response is Success){
        isProcessing(false);
        // messageList.addAll(response.response as List<Message>);
        refresh();
        Get.toNamed(AppRoutes.MESSAGE);
      }
      if(response is Failure){
        isProcessing(false);
        print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      isProcessing(false);
      print("Exception  "+ex.toString());
    }
  }
  // DEL CONFIRLMATION
  void confirmDelete(msg_id){
    Get.defaultDialog(
        title: 'Confirmation',
        titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        middleText: 'Voulez-vous supprimer ce message ?' ,
        middleTextStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.all(5.0),
        textConfirm: 'Confirmer',
        confirmTextColor: Colors.white,
        textCancel: 'Annuler',
        cancelTextColor: Colors.red,
        onConfirm: (){
          deleteMessage(msg_id);
        }
    );
  }
  // DELETE MESSAGE
  deleteMessage(id) async {
    try{
      isProcessing(true);
      final response = await MessageServices.deleteMessage(id);
      if(response is Success){
        isProcessing(false);
        refresh();
        Get.toNamed(AppRoutes.MESSAGE);
      }
      if(response is Failure){
        isProcessing(false);
        print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      isProcessing(false);
      print("Exception  "+ex.toString());
    }
  }

  likeMessage(message_id) async {
    try{
      final response = await MessageServices.likeMessage(message_id);
      if(response is Success){
        final message_index = allMessageList.indexWhere((element) => element.id == message_id);
        final _message = allMessageList[message_index];
        manageLike(_message, message_index);
      }
      if(response is Failure){
        print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      print("Exception  "+ex.toString());
    }
  }
  manageLike(Message message, index) async{
    if(message.id != null){
      if(message.liked == 2){
        message.unLikeCount! > 0 ? message.unLikeCount = message.unLikeCount! - 1 : message.unLikeCount = 0;
      }
      message.liked = 1;
      message.likeCount = message.likeCount! + 1;

      allMessageList.replaceRange(index, index+1, [message]);
      messageList.replaceRange(index, index+1, [message]);
      selectedMessage.value = Message();
      selectedMessage.value = allMessageList[index] == message ? allMessageList[index] : messageList[index];

    }
  }
  unLikeMessage(message_id) async {
    try{
      final response = await MessageServices.unLikeMessage(message_id);
      if(response is Success){
        final message_index = allMessageList.indexWhere((element) => element.id == message_id);
        final _message = allMessageList[message_index];
        manageUnlike(_message, message_index);
      }
      if(response is Failure){
        print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      print("Exception  "+ex.toString());
    }
  }
  manageUnlike(Message message, index) async{
    if(message.liked == 1){
      message.likeCount! > 0 ? message.likeCount = message.likeCount! - 1 : message.likeCount = 0;
    }
    message.liked = 2;
    message.unLikeCount = message.unLikeCount! + 1;

    allMessageList.replaceRange(index, index+1, [message]);
    messageList.replaceRange(index, index+1, [message]);
    selectedMessage.value = Message();
    selectedMessage.value = allMessageList[index] == message ? allMessageList[index] : messageList[index];
  }

    // SET SELECTED COMMERCE
    void setSelectedMessage(Message message){
      selectedMessage.value = message;
    }
    void setSelectedMessageType(MessageType message_type){
      selectedMessageType.value = message_type;
    }
    // SET SELECTED TYPE NAME
    void setSelectedType(var type){
      selectedType.value = type;
    }
    // REFRESH PAGE
    void refresh(){
      messageList.clear();
      allMessageList.clear();
      menuMessageTypesList.clear();
      myMessagesTypesList.clear();
      allMessagesTypesList.clear();

      setSelectedType('');
      getMessageTypes();
      getMessages(page);
      getAllMessages();
      // setSelectedMessageType(MessageType());
    }

    // SHOW SNACKBAR
    showSnackBar(String title, String message, Color bgColor){
      Get.snackbar(title, message, backgroundColor: bgColor,
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }

    @override
    void onInit() {
    super.onInit();
    txtLibelleController = TextEditingController();
    txtDescriptionController = TextEditingController();
    txtNomController = TextEditingController();
    txtPrenomController = TextEditingController();
    txtEmailController = TextEditingController();
    txtContactController = TextEditingController();

      refresh();
    }

  @override
  void onReady() {
    super.onReady();
    // print('ready');
  }

  clearFields(){
    txtLibelleController.dispose();
    txtDescriptionController.dispose();
    txtNomController.dispose();
    txtPrenomController.dispose();
    txtEmailController.dispose();
    txtContactController.dispose();
  }

  @override
  void onClose() {
    removeFile();
    clearFields();
  }

  String? validEmail(value){
    if(!GetUtils.isEmail(value)){
      return 'Adresse email invalide';
    }
    return null;
  }
  String? validLibelle(value){
    if (value == null || value.isEmpty)
      return "Entrer l'objet du message";
    if (value.length < 3)
      return "Objet du message trop court(Au moins 3 caractères)";
    return null;
  }
  String? validDescription(value){
    if (value == null || value.isEmpty)
      return "Entrer une description pour nous faciliter la tâche svp";
    if (value.length < 8)
      return "Description trop courte(Au moins 8 caractères)";
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
