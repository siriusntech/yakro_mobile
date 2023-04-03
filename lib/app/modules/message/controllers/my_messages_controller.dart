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
      isDataProcessing(true);
      final response = await MessageServices.getMessageTypes();
      if(response is Success){
        isDataProcessing(false);
        messageTypesList.addAll(response.response as List<MessageType>);
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
        print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      isProcessing(false);
      print("Exception  "+ex.toString());
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
        print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      isProcessing(false);
      print("Exception  "+ex.toString());
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
        print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      isProcessing(false);
      print("Exception  "+ex.toString());
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
        print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      print("Exception  "+ex.toString());
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
        print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      print("Exception  "+ex.toString());
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
