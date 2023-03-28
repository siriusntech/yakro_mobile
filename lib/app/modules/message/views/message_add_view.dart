import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Utils/app_constantes.dart';
import '../../../controllers/main_controller.dart';
import '../../../widgets/text_widget.dart';
import '../../../widgets/video_widget.dart';
import '../controllers/message_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MessageAddView extends GetView<MessageController> {
  final MainController settingsCtrl = Get.find();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.appbarColorFromCode,
        title: Obx(()=> TextWidget(
          text: controller.selectedType.value != ''
              ? controller.selectedType.value
              : "Contactez la mairie",
          fontSize: 14,
          alignement: TextAlign.center,
          fontWeight: FontWeight.bold,
          scaleFactor: 1.2,
          color: Colors.white,
        )),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Form(
          key: controller.form_key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Center(
            child: Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15),
              child: ListView(
                children: [
                  SizedBox(
                    height: 00,
                  ),
                  Obx(()=>Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: controller.selectedMessageType.value.description ??
                            "Toute l'équipe est à votre écoute pour réponde à vos questions et vous guider dans vos démarches.",
                        fontSize: 18,
                        alignement: TextAlign.center,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 26.0,
                      ),
                      TextWidget(
                        text: "Objet*",
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: controller.txtLibelleController,
                        validator: (value) {
                          return controller.validLibelle(value);
                        },
                        decoration: InputDecoration(
                            hintText: "Ex: la santé, les jeunes, l'éducation (Au moins 3 caractères)",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 12),
                            prefixIcon: Icon(Icons.pending),
                            errorStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextWidget(
                        text: "Description*",
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: controller.txtDescriptionController,
                        validator: (value) {
                          return controller.validDescription(value);
                        },
                        decoration: InputDecoration(
                            hintText: "Précisez ici toutes les informations qui pourraient aider nos équipes (Au moins 8 caractères)",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            errorStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        maxLines: 10,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextWidget(
                        text: "Fichier(facultatif)",
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      if (controller.addFile.value == false && controller.filePicked.value == 'video')
                        Container(
                          width: 200,
                          height: 200,
                          child: VideoWidget(from: 'local', file: controller.videoFile.value),
                        ),
                      if (controller.addFile.value == false && controller.filePicked.value == 'image')
                        Container(
                          width: 200,
                          height: 200,
                          child: Image.file(
                            controller.imageFile.value,
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (controller.addFile.value == false && controller.filePicked.value == '')
                        Container(),
                      if (controller.addFile.value == true)
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  controller.choosePhoto(context);
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
                                  controller.chooseVideo(context);
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
                                  controller.removeFile();
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
                                  controller.addFile.value = true;
                                },
                                style: ButtonStyle(
                                    alignment: Alignment.bottomLeft),
                                child: Row(
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
                            if (controller.filePicked.value != '')
                              TextButton(
                                  onPressed: () {
                                    controller.removeFile();
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
                      controller.selectedMessageType.value.nom.toString().contains('Rendez-vous')
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          TextWidget(
                            text: "Vos informations",
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          TextWidget(
                            text:
                            "Les informations renseignées ci-dessous serviront uniquement au traitement de cette intervention.",
                            fontSize: 16.0,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextWidget(
                            text: "Nom*",
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: controller.txtNomController,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return "Nom obligatoire";
                              if (value.length < 2)
                                return "le nom est trop court(Au moins 2 caractères)";
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText:
                                "Votre nom(Au moins 2 caractères)",
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(15)),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 12),
                                errorStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextWidget(
                            text: "Prenom*",
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: controller.txtPrenomController,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return "Prenom obligatoire";
                              if (value.length < 2)
                                return "le prenom est trop court(Au moins 2 caractères)";
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText:
                                "Votre prenom(Au moins 2 caractères)",
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(15)),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 12),
                                errorStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextWidget(
                            text: "Email(facultatif)",
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: controller.txtEmailController,
                            decoration: InputDecoration(
                                hintText: "Votre adresse email",
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(15)),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 12),
                                errorStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextWidget(
                            text: "Numéro de téléphone*",
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: controller.txtContactController,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return "Numéro de téléphone obligatoire.";
                              if (value.length != 10)
                                return "le numéro de téléphone est de 10 chiffres svp.";
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Votre numéro de téléphone",
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(15)),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 12),
                                errorStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      )
                          : Container(),
                      SizedBox(
                        height: 18,
                      ),
                      Center(
                        child: controller.isProcessing.value == true
                            ? SpinKitFadingCircle(
                          color: Colors.blue,
                          size: 50.0,
                        )
                            : ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                              shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                              padding: MaterialStateProperty.all(EdgeInsets.only(left: 25, right: 25))),
                          onPressed: (){
                            controller.checkForm();
                            if (controller.addFormIsValid.value == true) {
                              var data = {};
                              if (controller.selectedType.toString().contains('Rendez-vous')) {
                                data = {
                                  'type_id': controller.selectedMessageType.value.id,
                                  'libelle': controller.txtLibelleController.text,
                                  'description': controller.txtDescriptionController.text,
                                  'fileUrl': controller.fileUrl.value != File('') ? controller.fileUrl.value : File(''),
                                  'nom': controller.txtNomController.text != '' ? controller.txtNomController.text : '',
                                  'prenom': controller.txtPrenomController.text != '' ? controller.txtPrenomController.text : '',
                                  'email': controller.txtEmailController.text != '' ? controller.txtEmailController.text : '',
                                  'contact': controller.txtContactController.text != '' ? controller.txtContactController.text : '',
                                };
                              } else {
                                data = {
                                  'type_id': controller.selectedMessageType.value.id,
                                  'libelle': controller.txtLibelleController.text,
                                  'description': controller.txtDescriptionController.text,
                                  'fileUrl': controller.fileUrl.value != File('') ? controller.fileUrl.value : File(''),
                                  'file_type': controller.isVideo.value == true ? 'video' : 'image',
                                  'nom': '',
                                  'prenom': '',
                                  'email': '',
                                  'contact': '',
                                };
                              }
                             controller.createMessage(data);
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
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
