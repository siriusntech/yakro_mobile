import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/data/api_status.dart';
import '../../../data/repository/message_services.dart';
import '../message_model.dart';
import '../message_type_model.dart';

class MyMessagesController extends GetxController {

  var messageList = List<Message>.empty(growable: true).obs;
  var allMessageList = List<Message>.empty(growable: true).obs;
  var messageTypesList = List<MessageType>.empty(growable: true).obs;
  var selectedMessage = Message().obs;
  var page = 1;
  var isDataProcessing = false.obs;
  var isAllDataProcessing = false.obs;
  var isProcessing = false.obs;
  var selectedType = ''.obs;
  var selectedMessageType = MessageType().obs;


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
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      isDataProcessing(false);
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }
  // GET MY MESSAGES BY TYPE
  getMyMessagesByType(typeId) async {
    try{
      isDataProcessing(true);
      final response = await MessageServices.getMessagesByType(typeId);
      if(response is Success){
        isDataProcessing(false);
        messageList.addAll(response.response as List<Message>);
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
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      isAllDataProcessing(false);
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }
  // GET ALL MESSAGES BY TYPE
  getMessagesByType(typeId) async {
    try{
      isAllDataProcessing(true);
      final response = await MessageServices.getMessagesByType(typeId);
      if(response is Success){
        isAllDataProcessing(false);
        allMessageList.addAll(response.response as List<Message>);
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
  // GET MESSAGE TYPES
  getMessageTypes() async {
    try{
      isDataProcessing(true);
      final response = await MessageServices.getMessageTypes();
      if(response is Success){
        isDataProcessing(false);
        messageTypesList.addAll(response.response as List<MessageType>);
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
  // CREATE NEW MESSAGE
  createMessage(data) async {
    try{
      isProcessing(true);
      final response = await MessageServices.getMessages();
      if(response is Success){
        isProcessing(false);
        messageList.addAll(response.response as List<Message>);
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
  // UPDATE MESSAGE
  updateMessage(id, data) async {
    try{
      isProcessing(true);
      final response = await MessageServices.getMessages();
      if(response is Success){
        isProcessing(false);
        messageList.addAll(response.response as List<Message>);
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
  // DELETE MESSAGE
  deleteMessage(id) async {
    try{
      isProcessing(true);
      final response = await MessageServices.getMessages();
      if(response is Success){
        isProcessing(false);
        messageList.addAll(response.response as List<Message>);
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
  // LIKE MESSAGE
  likeMessage(message_id) async {
    try{
      final response = await MessageServices.getMessages();
      if(response is Success){
        messageList.addAll(response.response as List<Message>);
      }
      if(response is Failure){
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }
  // UN_LIKE MESSAGE
  unLikeMessage(message_id) async {
    try{
      final response = await MessageServices.getMessages();
      if(response is Success){
        messageList.addAll(response.response as List<Message>);
      }
      if(response is Failure){
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
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
    void refresh() async{
      messageList.clear();
      allMessageList.clear();
      messageTypesList.clear();
      setSelectedType('');
      await getMessageTypes();
      await getMessages(page);
      await getAllMessages();
      setSelectedMessageType(MessageType());
    }

    // SHOW SNACKBAR
    showSnackBar(String title, String message, Color bgColor){
      Get.snackbar(title, message, backgroundColor: bgColor,
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }

    @override
    void onInit() {
      super.onInit();
      refresh();
    }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
