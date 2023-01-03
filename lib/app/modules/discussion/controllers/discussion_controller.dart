import 'dart:async';
import 'dart:io';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mon_plateau/app/modules/discussion/widgets/commentaire_card_widget.dart';
import '../../../Utils/app_constantes.dart';
import '../../../data/repository/commentaire_services.dart';
import '../../../data/repository/data/api_status.dart';
import '../../../data/repository/discussion_services.dart';
import '../../../widgets/alerte_widgets.dart';
import '../../../widgets/text_widget.dart';
import '../../../widgets/video_widget.dart';
import '../commentaire_model.dart';
import '../discussion_model.dart';

class DiscussionController extends GetxController {

  var discussionList = List<Discussion>.empty(growable: true).obs;
  var commentaireList = List<Commentaire>.empty(growable: true).obs;
  var reponseList = List<Commentaire>.empty(growable: true).obs;
  var allDiscussionList = List<Discussion>.empty(growable: true).obs;

  var selectedDiscussion = Discussion().obs;
  var selectedCommentaire = Commentaire().obs;
  var selectedReponse = Commentaire().obs;

  var isDataProcessing = false.obs;
  var isAllDataProcessing = false.obs;

  var fileUrl = ''.obs;
  var loading = false.obs;
  var addFile = false.obs;
  var enabledBtnSend = false.obs;
  var user_id = 0.obs;
  var isVideo = false.obs;
  var filePicked = ''.obs;

  var imageFile = File('').obs;
  var videoFile = File('').obs;
  final picker = ImagePicker();

  var isProcessing = false.obs;

  // SUJETS
  final form_key = GlobalKey<FormState>();
  final edit_form_key = GlobalKey<FormState>();
  late TextEditingController sujetController;
  var addFormIsValid = false.obs;
  var editFormIsValid = false.obs;
  // COMMENTAIRES
  final com_form_key = GlobalKey<FormState>();
  final com_edit_form_key = GlobalKey<FormState>();
  late TextEditingController texteController;
  var addComFormIsValid = false.obs;
  var editComFormIsValid = false.obs;
  // REPONSES
  var addRepFormIsValid = false.obs;
  var editRepFormIsValid = false.obs;
  final rep_form_key = GlobalKey<FormState>();
  final rep_edit_form_key = GlobalKey<FormState>();

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

  void choosePhoto() {
    Get.bottomSheet(
        Container(
          width: double.infinity,
          height: 100,
          color: Colors.white,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: Get.width / 2 - 35,
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
                width: Get.width / 2 - 35,
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
        ),
        elevation: 10,
        backgroundColor: Colors.white,
    );
  }

  void chooseVideo() {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        height: 100,
        color: Colors.white,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: Get.width / 2 - 35,
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
              width: Get.width / 2 - 35,
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
      ),
      elevation: 10,
      backgroundColor: Colors.white,
    );
  }

  // REFRESH PAGE
  void refresh(){
    discussionList.clear();
    // allDiscussionList.clear();

    getDiscussions();
    // getAllDiscussions();
  }

  initFields() async{
    sujetController  = TextEditingController();
    texteController  = TextEditingController();
  }

  disposeFields(){
    sujetController.dispose();
    texteController.dispose();
  }

  clearFields(){
    sujetController.clear();
    texteController.clear();
  }

  removeFile(){
    fileUrl.value = '';
    isVideo.value = false;
    filePicked.value = '';
    addFile.value = false;
  }

  showAddHistoriqueForm(){
    Get.bottomSheet(
        Container(
            // height: Get.height / 1.7,
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Obx(() => Form(
              key: form_key,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: sujetController,
                      validator: (value) {
                        return validSujet(value);
                      },
                      decoration: InputDecoration(
                          hintText: "De quoi voulez-vous discuter ?...",
                          labelText: "De quoi voulez-vous discuter ?",
                          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(15)),
                          errorStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
                      ),
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    ),
                    SizedBox(height: 15,),
                    TextWidget(text: "Fichier(facultatif)",fontWeight: FontWeight.bold, fontSize: 16.0,alignement: TextAlign.start,),
                    if (addFile.value == false && filePicked.value == 'video')
                      Container(
                        width: 200,
                        height: 120,
                        child: VideoWidget(from: 'local', file: videoFile.value),
                      ),
                    if (addFile.value == false && filePicked.value == 'image')
                      Container(
                        width: 200,
                        height: 120,
                        child: Image.file(
                          imageFile.value,
                          fit: BoxFit.cover,
                        ),
                      ),
                    if (addFile.value == false && filePicked.value == '')
                      Container(
                        width: 130,
                        height: 120,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          elevation: 4.0,
                          child: Image.asset(
                            DEFAULT_FILE,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    if (addFile.value == true)
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                choosePhoto();
                              },
                              style: ButtonStyle(
                                  alignment: Alignment.bottomLeft),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    color: Colors.blue,
                                    size: 25,
                                  ),
                                  TextWidget(
                                    text: "Image",
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 6,
                          ),
                          TextButton(
                              onPressed: () {
                                chooseVideo();
                              },
                              style: ButtonStyle(
                                  alignment: Alignment.bottomLeft),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.videocam,
                                    color: Colors.blue,
                                    size: 25,
                                  ),
                                  TextWidget(
                                    text: "Vidéo",
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 6,
                          ),
                          TextButton(
                              onPressed: () {
                                removeFile();
                              },
                              style: ButtonStyle(
                                  alignment: Alignment.bottomLeft),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red,
                                    size: 25,
                                  ),
                                  TextWidget(
                                    text: "Annuler",
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  )
                                ],
                              ))
                        ],
                      )
                    else
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                addFile.value = true;
                              },
                              style: ButtonStyle(
                                  alignment: Alignment.bottomLeft),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.add_a_photo_rounded,
                                    color: Colors.blue,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  TextWidget(
                                    text: "Ajouter un fichier",
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 4,
                          ),
                          if (filePicked.value != '')
                            TextButton(
                                onPressed: () {
                                  removeFile();
                                },
                                style: ButtonStyle(
                                    alignment: Alignment.bottomLeft),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.red,
                                      size: 25,
                                    ),
                                    TextWidget(
                                      text: "Supprimer",
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    )
                                  ],
                                )
                            )
                        ],
                      ),
                    // SizedBox(height: 8,),
                    Center(
                      child: Row(
                        children: [
                          isProcessing.value == true
                              ? SpinKitFadingCircle(
                            color: Colors.blue,
                            size: 40.0,
                          ) : Row(
                              children:[
                                ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                                      padding: MaterialStateProperty.all(EdgeInsets.only(left: 25, right: 25))
                                  ),
                                  onPressed: (){
                                    checkForm();
                                    if (addFormIsValid.value == true) {
                                      var data = {
                                        'sujet': sujetController.text,
                                        'fileUrl': fileUrl.value != File('') ? fileUrl.value : File(''),
                                        'file_type': isVideo.value == true ? 'video' : 'image',
                                      };
                                      createDiscussion(data);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  label: TextWidget(
                                    text: "Envoyer",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                                      padding: MaterialStateProperty.all(EdgeInsets.only(left: 25, right: 25))
                                  ),
                                  onPressed: (){
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                  ),
                                  label: TextWidget(
                                    text: "Annuler",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
        ),
        isScrollControlled: true
    );
  }

  showEditHistoriqueForm(){
    sujetController.text = selectedDiscussion.value.sujet!;
    Get.bottomSheet(
        Container(
            // height: Get.height / 1.7,
            margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Obx(() => Form(
              key: edit_form_key,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: sujetController,
                      validator: (value) {
                        return validSujet(value);
                      },
                      decoration: InputDecoration(
                          hintText: "Entrez le sujet...",
                          labelText: "Sujet",
                          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(15)),
                          errorStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
                      ),
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    ),
                    SizedBox(height: 15,),
                    TextWidget(text: "Fichier(facultatif)",fontWeight: FontWeight.bold, fontSize: 16.0,alignement: TextAlign.start,),
                    if (addFile.value == false && filePicked.value == 'video')
                      Container(
                        width: 200,
                        height: 120,
                        child: VideoWidget(from: 'local', file: videoFile.value),
                      ),
                    if (addFile.value == false && filePicked.value == 'image')
                      Container(
                        width: 200,
                        height: 120,
                        child: Image.file(
                          imageFile.value,
                          fit: BoxFit.cover,
                        ),
                      ),
                    if (addFile.value == false && filePicked.value == '')
                      Container(
                        width: 130,
                        height: 120,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          elevation: 4.0,
                          child: Image.asset(
                            DEFAULT_FILE,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    if (addFile.value == true)
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                choosePhoto();
                              },
                              style: ButtonStyle(
                                  alignment: Alignment.bottomLeft),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    color: Colors.blue,
                                    size: 25,
                                  ),
                                  TextWidget(
                                    text: "Image",
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 6,
                          ),
                          TextButton(
                              onPressed: () {
                                chooseVideo();
                              },
                              style: ButtonStyle(
                                  alignment: Alignment.bottomLeft),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.videocam,
                                    color: Colors.blue,
                                    size: 25,
                                  ),
                                  TextWidget(
                                    text: "Vidéo",
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 6,
                          ),
                          TextButton(
                              onPressed: () {
                                removeFile();
                              },
                              style: ButtonStyle(
                                  alignment: Alignment.bottomLeft),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red,
                                    size: 25,
                                  ),
                                  TextWidget(
                                    text: "Annuler",
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  )
                                ],
                              ))
                        ],
                      )
                    else
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                addFile.value = true;
                              },
                              style: ButtonStyle(
                                  alignment: Alignment.bottomLeft),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.add_a_photo_rounded,
                                    color: Colors.blue,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  TextWidget(
                                    text: "Ajouter un fichier",
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 4,
                          ),
                          if (filePicked.value != '')
                            TextButton(
                                onPressed: () {
                                  removeFile();
                                },
                                style: ButtonStyle(
                                    alignment: Alignment.bottomLeft),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.red,
                                      size: 25,
                                    ),
                                    TextWidget(
                                      text: "Supprimer",
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    )
                                  ],
                                )
                            )
                        ],
                      ),
                    // SizedBox(height: 8,),
                    Center(
                      child: Row(
                        children: [
                          isProcessing.value == true
                              ? SpinKitFadingCircle(
                            color: Colors.blue,
                            size: 50.0,
                          ) : Row(
                              children:[
                                ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                                      padding: MaterialStateProperty.all(EdgeInsets.only(left: 25, right: 25))
                                  ),
                                  onPressed: (){
                                    checkEditForm();
                                    if (editFormIsValid.value == true) {
                                      var data = {
                                        'sujet': sujetController.text,
                                        'fileUrl': fileUrl.value != File('') ? fileUrl.value : File(''),
                                        'file_type': isVideo.value == true ? 'video' : 'image',
                                      };
                                      updateDiscussion(selectedDiscussion.value.id, data);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  label: TextWidget(
                                    text: "Enrégister",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                                      padding: MaterialStateProperty.all(EdgeInsets.only(left: 25, right: 25))
                                  ),
                                  onPressed: (){
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                  ),
                                  label: TextWidget(
                                    text: "Annuler",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
        ),
        isScrollControlled: true
    );
  }

  getDiscussions() async {
    // timer?.cancel();
    try{
      SharedPreferences storage = await SharedPreferences.getInstance();
      user_id.value = storage.getInt('user_id') ?? 0;

      isDataProcessing(true);
      final response = await DiscussionServices.getDiscussions(user_id.value);
      if(response is Success){
        isDataProcessing(false);
        discussionList.addAll(response.response as List<Discussion>);

        if(selectedDiscussion.value.id != null){
          selectedDiscussion.value = discussionList.firstWhere((element) => element.id == selectedDiscussion.value.id);
          setSelectedDiscussion(selectedDiscussion.value);
        }
      }
      if(response is Failure){
        isDataProcessing(false);
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      isDataProcessing(false);
      showSnackBar("Exception", ex.toString(), Colors.red);
    }

    // getDiscussionsInRealTime();
  }

  getAllDiscussions() async {
    try{
      isAllDataProcessing(true);
      final response = await DiscussionServices.getAllDiscussions(user_id.value);
      if(response is Success){
        isAllDataProcessing(false);
        allDiscussionList.clear();
        allDiscussionList.addAll(response.response as List<Discussion>);
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

  createDiscussion(data) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    user_id.value = storage.getInt('user_id') ?? 0;
    try{
      timer?.cancel();
      isProcessing(true);
      final response = await DiscussionServices.createDiscussion(data, user_id.value);
      if(response is Success){
        isProcessing(false);
        clearFields();
        removeFile();
        refresh();
        Get.back();
        getDiscussionsInRealTime();
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

  setSelectedDiscussion(Discussion discussion){
    selectedDiscussion.value = discussion;

    reponseList.clear();
    commentaireList.clear();
    commentaireList.addAll(discussion.commentaires ?? []);
    setReponseList();
  }

  setReponseList(){
    for(var com in commentaireList){
      reponseList.addAll(com.reponses as List<Commentaire>);
    }
    // print(reponseList.length.toString());
  }

  updateDiscussion(disc_id, data) async {
    try{
      isProcessing(true);
      final response = await DiscussionServices.updateDiscussion(disc_id, data, user_id.value);
      if(response is Success){
        isProcessing(false);
        clearFields();
        removeFile();
        refresh();
        Get.back();
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
  void confirmDelete(disc_id){
    Get.defaultDialog(
        title: 'Confirmation',
        titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        middleText: 'Voulez-vous supprimer cette discussion ?' ,
        middleTextStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.all(5.0),
        textConfirm: 'Confirmer',
        confirmTextColor: Colors.white,
        textCancel: 'Annuler',
        cancelTextColor: Colors.red,
        onConfirm: (){
          deleteDiscussion(disc_id);
        }
    );
  }

  deleteDiscussion(id) async {
    try{
      isProcessing(true);
      final response = await DiscussionServices.deleteDiscussion(id);
      if(response is Success){
        isProcessing(false);
        refresh();
        Get.back();
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

  likeDiscussion(discussion_id) async {
    try{
      final response = await DiscussionServices.likeDiscussion(discussion_id, user_id.value);
      if(response is Success){
        final discussion_index = discussionList.indexWhere((element) => element.id == discussion_id);
        final _discussion = discussionList[discussion_index];
        manageLike(_discussion, discussion_index);
      }
      if(response is Failure){
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  manageLike(Discussion discussion, index) async{
    if(discussion.id != null){
      if(discussion.liked == 2){
        discussion.unLikeCount! > 0 ? discussion.unLikeCount = discussion.unLikeCount! - 1 : discussion.unLikeCount = 0;
      }
      discussion.liked = 1;
      discussion.likeCount = discussion.likeCount! + 1;

      // allDiscussionList.replaceRange(index, index+1, [discussion]);
      discussionList.replaceRange(index, index+1, [discussion]);
      selectedDiscussion.value = Discussion();
      selectedDiscussion.value = discussionList[index];
      // selectedDiscussion.value = allDiscussionList[index] == discussion ? allDiscussionList[index] : discussionList[index];
    }
  }

  unLikeDiscussion(discussion_id) async {
    try{
      final response = await DiscussionServices.unLikeDiscussion(discussion_id, user_id.value);
      if(response is Success){
        final discussion_index = discussionList.indexWhere((element) => element.id == discussion_id);
        final _discussion = discussionList[discussion_index];
        manageUnlike(_discussion, discussion_index);
      }
      if(response is Failure){
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  manageUnlike(Discussion discussion, index) async{
    if(discussion.liked == 1){
      discussion.likeCount! > 0 ? discussion.likeCount = discussion.likeCount! - 1 : discussion.likeCount = 0;
    }
    discussion.liked = 2;
    discussion.unLikeCount = discussion.unLikeCount! + 1;

    // allDiscussionList.replaceRange(index, index+1, [discussion]);
    discussionList.replaceRange(index, index+1, [discussion]);
    selectedDiscussion.value = Discussion();
    selectedDiscussion.value = discussionList[index];
    // selectedDiscussion.value = allDiscussionList[index] == discussion ? allDiscussionList[index] : discussionList[index];
  }


  // COMMENTAIRES
  showAddCommentaireForm(){
    Get.bottomSheet(
        Container(
            // height: Get.height / 2.5,
            margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Obx(() => Form(
              key: com_form_key,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(text: "Commentaire:", fontSize: 16, fontWeight: FontWeight.bold,),
                    TextWidget(text: selectedDiscussion.value.sujet, fontSize: 16,),
                    Divider(),
                    TextFormField(
                      controller: texteController,
                      validator: (value) {
                        return validTexte(value);
                      },
                      decoration: InputDecoration(
                          hintText: "Commentaire...",
                          labelText: "Commentaire",
                          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(15)),
                          errorStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
                      ),
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    ),
                    SizedBox(height: 15,),
                    Center(
                      child: Row(
                        children: [
                          isProcessing.value == true
                              ? SpinKitFadingCircle(
                            color: Colors.blue,
                            size: 50.0,
                          ) : Row(
                              children:[
                                ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                                      padding: MaterialStateProperty.all(EdgeInsets.only(left: 25, right: 25))
                                  ),
                                  onPressed: (){
                                    checkComForm();
                                    if (addComFormIsValid.value == true) {
                                      var data = {
                                        'texte': texteController.text,
                                        'discussion_id': selectedDiscussion.value.id.toString(),
                                      };
                                      createCommentaire(data);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  label: TextWidget(
                                    text: "Commenter",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                                      padding: MaterialStateProperty.all(EdgeInsets.only(left: 25, right: 25))
                                  ),
                                  onPressed: (){
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                  ),
                                  label: TextWidget(
                                    text: "Annuler",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
        ),
        isScrollControlled: true
    );
  }

  showEditCommentaireForm(){
    texteController.text = selectedCommentaire.value.texte!;
    Get.bottomSheet(
        Container(
            // height: Get.height / 2.5,
            margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Obx(() => Form(
              key: com_edit_form_key,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: texteController,
                      validator: (value) {
                        return validTexte(value);
                      },
                      decoration: InputDecoration(
                          hintText: "Commentaire...",
                          labelText: "Commentaire",
                          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(15)),
                          errorStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
                      ),
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    ),
                    SizedBox(height: 15,),
                    Center(
                      child: Row(
                        children: [
                          isProcessing.value == true
                              ? SpinKitFadingCircle(
                            color: Colors.blue,
                            size: 50.0,
                          ) : Row(
                              children:[
                                ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                                      padding: MaterialStateProperty.all(EdgeInsets.only(left: 25, right: 25))
                                  ),
                                  onPressed: (){
                                    checkComEditForm();
                                    if (editComFormIsValid.value == true) {
                                      var data = {
                                        'texte': texteController.text,
                                      };
                                      updateCommentaire(selectedCommentaire.value.id, data);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  label: TextWidget(
                                    text: "Enrégister",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                                      padding: MaterialStateProperty.all(EdgeInsets.only(left: 25, right: 25))
                                  ),
                                  onPressed: (){
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                  ),
                                  label: TextWidget(
                                    text: "Annuler",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
        ),
        isScrollControlled: true
    );
  }

  createCommentaire(data) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    user_id.value = storage.getInt('user_id') ?? 0;
    timer?.cancel();
    try{
      isProcessing(true);
      final response = await CommentaireServices.createCommentaire(data, user_id.value);
      if(response is Success){
        isProcessing(false);
        clearFields();
        removeFile();
        refresh();
        Get.back();
        getDiscussionsInRealTime();
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

  setSelectedCommentaire(Commentaire commentaire){
    selectedCommentaire.value = commentaire;
  }

  updateCommentaire(disc_id, data) async {
    try{
      isProcessing(true);
      final response = await CommentaireServices.updateCommentaire(disc_id, data, user_id.value);
      if(response is Success){
        isProcessing(false);
        clearFields();
        removeFile();
        refresh();
        Get.back();
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
  void confirmComDelete(com_id){
    Get.defaultDialog(
        title: 'Confirmation',
        titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        middleText: 'Voulez-vous supprimer ce commentaire ?' ,
        middleTextStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.all(5.0),
        textConfirm: 'Confirmer',
        confirmTextColor: Colors.white,
        textCancel: 'Annuler',
        cancelTextColor: Colors.red,
        onConfirm: (){
          deleteCommentaire(com_id);
        }
    );
  }

  deleteCommentaire(id) async {
    try{
      isProcessing(true);
      final response = await CommentaireServices.deleteCommentaire(id);
      if(response is Success){
        isProcessing(false);
        refresh();
        Get.back();
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

  likeCommentaire(commentaire_id) async {
    try{
      final response = await CommentaireServices.likeCommentaire(commentaire_id, user_id.value);
      if(response is Success){
        final commentaire_index = commentaireList.indexWhere((element) => element.id == commentaire_id);
        final _commentaire = commentaireList[commentaire_index];
        manageComLike(_commentaire, commentaire_index);
      }
      if(response is Failure){
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  manageComLike(Commentaire commentaire, index) async{
    if(commentaire.id != null){
      if(commentaire.liked == 2){
        commentaire.unLikeCount! > 0 ? commentaire.unLikeCount = commentaire.unLikeCount! - 1 : commentaire.unLikeCount = 0;
      }
      commentaire.liked = 1;
      commentaire.likeCount = commentaire.likeCount! + 1;

      commentaireList.replaceRange(index, index+1, [commentaire]);
      // commentaireList.replaceRange(index, index+1, [commentaire]);
      selectedCommentaire.value = Commentaire();
      selectedCommentaire.value = commentaireList[index];
    }
  }

  unLikeCommentaire(commentaire_id) async {
    try{
      final response = await CommentaireServices.unLikeCommentaire(commentaire_id, user_id.value);
      if(response is Success){
        final commentaire_index = commentaireList.indexWhere((element) => element.id == commentaire_id);
        final _commentaire = commentaireList[commentaire_index];
        manageComUnlike(_commentaire, commentaire_index);
      }
      if(response is Failure){
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  manageComUnlike(Commentaire commentaire, index) async{
    if(commentaire.liked == 1){
      commentaire.likeCount! > 0 ? commentaire.likeCount = commentaire.likeCount! - 1 : commentaire.likeCount = 0;
    }
    commentaire.liked = 2;
    commentaire.unLikeCount = commentaire.unLikeCount! + 1;

    commentaireList.replaceRange(index, index+1, [commentaire]);
    selectedCommentaire.value = Commentaire();
    selectedCommentaire.value = commentaireList[index];
  }

  // REPONSES
  showAddReponseForm(){
    Get.bottomSheet(
        Container(
            // height: Get.height / 2.5,
            margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Obx(() => Form(
              key: rep_form_key,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommentaireSimpleCardWidget(commentaire: selectedCommentaire.value),
                    TextFormField(
                      controller: texteController,
                      validator: (value) {
                        return validTexte(value);
                      },
                      decoration: InputDecoration(
                          hintText: "Reponse...",
                          labelText: "Reponse",
                          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(15)),
                          errorStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
                      ),
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    ),
                    SizedBox(height: 15,),
                    Center(
                      child: Row(
                        children: [
                          isProcessing.value == true
                              ? SpinKitFadingCircle(
                            color: Colors.blue,
                            size: 50.0,
                          ) : Row(
                              children:[
                                ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                                      padding: MaterialStateProperty.all(EdgeInsets.only(left: 25, right: 25))
                                  ),
                                  onPressed: (){
                                    checkRepForm();
                                    if (addRepFormIsValid.value == true) {
                                      var data = {
                                        'texte': texteController.text,
                                        'main_commentaire_id': selectedCommentaire.value.id.toString(),
                                      };
                                      createReponse(data);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  label: TextWidget(
                                    text: "Commenter",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                                      padding: MaterialStateProperty.all(EdgeInsets.only(left: 25, right: 25))
                                  ),
                                  onPressed: (){
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                  ),
                                  label: TextWidget(
                                    text: "Annuler",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
        ),
        isScrollControlled: true
    );
  }

  showEditReponseForm(){
    texteController.text = selectedCommentaire.value.texte!;
    Get.bottomSheet(
        Container(
            // height: Get.height / 2.5,
            margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Obx(() => Form(
              key: rep_edit_form_key,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: texteController,
                      validator: (value) {
                        return validTexte(value);
                      },
                      decoration: InputDecoration(
                          hintText: "Reponse...",
                          labelText: "Reponse",
                          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(15)),
                          errorStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
                      ),
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    ),
                    SizedBox(height: 15,),
                    Center(
                      child: Row(
                        children: [
                          isProcessing.value == true
                              ? SpinKitFadingCircle(
                            color: Colors.blue,
                            size: 50.0,
                          ) : Row(
                              children:[
                                ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                                      padding: MaterialStateProperty.all(EdgeInsets.only(left: 25, right: 25))
                                  ),
                                  onPressed: (){
                                    checkRepEditForm();
                                    if (editRepFormIsValid.value == true) {
                                      var data = {
                                        'texte': texteController.text,
                                      };
                                      updateReponse(selectedReponse.value.id, data);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  label: TextWidget(
                                    text: "Enrégister",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                                      padding: MaterialStateProperty.all(EdgeInsets.only(left: 25, right: 25))
                                  ),
                                  onPressed: (){
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                  ),
                                  label: TextWidget(
                                    text: "Annuler",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
        ),
        isScrollControlled: true
    );
  }

  createReponse(data) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    user_id.value = storage.getInt('user_id') ?? 0;
    timer?.cancel();
    try{
      isProcessing(true);
      final response = await CommentaireServices.createReponse(data, user_id.value);
      if(response is Success){
        isProcessing(false);
        clearFields();
        removeFile();
        refresh();
        Get.back();
        getDiscussionsInRealTime();
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

  setSelectedReponse(Commentaire reponse){
    selectedCommentaire.value = reponse;
  }

  updateReponse(disc_id, data) async {
    try{
      isProcessing(true);
      final response = await CommentaireServices.updateCommentaire(disc_id, data, user_id.value);
      if(response is Success){
        isProcessing(false);
        clearFields();
        removeFile();
        refresh();
        Get.back();
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
  void confirmRepDelete(com_id){
    Get.defaultDialog(
        title: 'Confirmation',
        titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        middleText: 'Voulez-vous supprimer ce reponse ?' ,
        middleTextStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.all(5.0),
        textConfirm: 'Confirmer',
        confirmTextColor: Colors.white,
        textCancel: 'Annuler',
        cancelTextColor: Colors.red,
        onConfirm: (){
          deleteCommentaire(com_id);
        }
    );
  }

  deleteReponse(id) async {
    try{
      isProcessing(true);
      final response = await CommentaireServices.deleteCommentaire(id);
      if(response is Success){
        isProcessing(false);
        refresh();
        Get.back();
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


  likeReponse(reponse_id) async {
    try{
      final response = await CommentaireServices.likeCommentaire(reponse_id, user_id.value);
      if(response is Success){
        final reponse_index = reponseList.indexWhere((element) => element.id == reponse_id);
        final _reponse = reponseList[reponse_index];
        manageRepLike(_reponse, reponse_index);
      }
      if(response is Failure){
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  manageRepLike(Commentaire reponse, index) async{
    if(reponse.id != null){
      if(reponse.liked == 2){
        reponse.unLikeCount! > 0 ? reponse.unLikeCount = reponse.unLikeCount! - 1 : reponse.unLikeCount = 0;
      }
      reponse.liked = 1;
      reponse.likeCount = reponse.likeCount! + 1;

      reponseList.replaceRange(index, index+1, [reponse]);
      // reponseList.replaceRange(index, index+1, [reponse]);
      // selectedCommentaire.value = Commentaire();
      // selectedCommentaire.value = reponseList[index];
    }
  }

  unLikeReponse(reponse_id) async {
    try{
      final response = await CommentaireServices.unLikeCommentaire(reponse_id, user_id.value);
      if(response is Success){
        final reponse_index = reponseList.indexWhere((element) => element.id == reponse_id);
        final _reponse = reponseList[reponse_index];
        manageRepUnlike(_reponse, reponse_index);
      }
      if(response is Failure){
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  manageRepUnlike(Commentaire reponse, index) async{
    if(reponse.liked == 1){
      reponse.likeCount! > 0 ? reponse.likeCount = reponse.likeCount! - 1 : reponse.likeCount = 0;
    }
    reponse.liked = 2;
    reponse.unLikeCount = reponse.unLikeCount! + 1;

    reponseList.replaceRange(index, index+1, [reponse]);
    // selectedCommentaire.value = Commentaire();
    // selectedCommentaire.value = reponseList[index];
  }

  String? validSujet(value){
    if (value == null || value.isEmpty)
      return "Entrer le Sujet";
    if (value.length < 1)
      return "Sujet trop court(Au moins 1 caractères)";
    if (value.length > 300)
      return "Sujet trop long(Au plus 300 caractères)";
    return null;
  }

  String? validTexte(value){
    if (value == null || value.isEmpty)
      return "Entrer le commentaire";
    if (value.length < 1)
      return "commentaire trop court(Au moins 1 caractères)";
    if (value.length > 300)
      return "commentaire trop long(Au plus 300 caractères)";
    return null;
  }

  // SUJETS
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

  // COMMENTAIRES
  void checkComForm(){
    addComFormIsValid(false);
    final isValid = com_form_key.currentState!.validate();
    if(!isValid){
      addComFormIsValid(false);
      return ;
    }
    com_form_key.currentState!.save();
    addComFormIsValid(true);
  }

  void checkComEditForm(){
    editComFormIsValid(false);
    final isValid = com_edit_form_key.currentState!.validate();
    if(!isValid){
      editComFormIsValid(false);
      return ;
    }
    com_edit_form_key.currentState!.save();
    editComFormIsValid(true);
  }

  // REPONSES
  void checkRepForm(){
    addRepFormIsValid(false);
    final isValid = rep_form_key.currentState!.validate();
    if(!isValid){
      addRepFormIsValid(false);
      return ;
    }
    rep_form_key.currentState!.save();
    addRepFormIsValid(true);
  }

  void checkRepEditForm(){
    editRepFormIsValid(false);
    final isValid = rep_edit_form_key.currentState!.validate();
    if(!isValid){
      editRepFormIsValid(false);
      return ;
    }
    rep_edit_form_key.currentState!.save();
    editRepFormIsValid(true);
  }


  late PusherClient pusher;
  // late Echo echo;

  var PUSHER_APP_ID = '1470609';
  var PUSHER_APP_KEY = 'b4a243a730a79f236b3d';
  var PUSHER_APP_SECRET = '990d31b1c004e403245f';
  var PUSHER_APP_CLUSTER = 'mt1';

  String? token = 'sdjksdhhdklfdfyuoezjsdfkllmjnhizefjiz';


  getDiscussionsInTime() async {
    try{
      SharedPreferences storage = await SharedPreferences.getInstance();
      user_id.value = storage.getInt('user_id') ?? 0;

      final response = await DiscussionServices.getDiscussions(user_id.value);
      if(response is Success){
        var currentList = List<Discussion>.empty(growable: true).obs;
        currentList.addAll(response.response as List<Discussion>);

        if(currentList.length > discussionList.length){
          print("new discussion");
          discussionList.clear();
          discussionList.addAll(response.response as List<Discussion>);
        }

        if(selectedDiscussion.value.id != null){
          selectedDiscussion.value = discussionList.firstWhere((element) => element.id == selectedDiscussion.value.id);
          setSelectedDiscussion(selectedDiscussion.value);
        }
      }
      if(response is Failure){
        // showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      // showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  // MAKE ALL AS READS
  makeDiscussionsAsRead() async{
    try{
      final response = await DiscussionServices.makeDiscussionsAsRead();
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

  var timer;

  getDiscussionsInRealTime() {
    timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      // print('hello');
      getDiscussionsInTime();
    });
  }

  @override
  void onInit() {
    super.onInit();
    // initSocket();
    // initSocketPusher();
    initFields();
    refresh();
    makeDiscussionsAsRead();
    // getDiscussionsInRealTime();
  }

  @override
  void onReady() {
    super.onReady();
    getDiscussionsInRealTime();
  }

  @override
  void onClose() {
    timer?.cancel();

    makeDiscussionsAsRead();
  }

}
