import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../controllers/main_controller.dart';
import '../../../widgets/text_widget.dart';
import '../../../widgets/video_widget.dart';
import '../controllers/alerte_controller.dart';

class AlerteEditView extends GetView<AlerteController> {
  final MainController settingsCtrl = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.vert_color_fonce,
        title: Obx(() => TextWidget(text: controller.selected_type_alerte.value, color: Colors.white,
          fontSize: 15, alignement: TextAlign.center, fontWeight: FontWeight.bold, scaleFactor: 1.2,
        )),
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Obx(() => Form(
          key: controller.edit_form_key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Center(
            child: Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: ListView(
                children: [
                  // SizedBox(height: 00,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0,),
                      TextWidget(text: controller.selectedTypeAlerteModel.value.description,
                        fontSize: 14, alignement: TextAlign.center, fontWeight: FontWeight.w600, scaleFactor: 1.2,
                      ),
                      SizedBox(height: 26.0,),
                      TextWidget(text: "Ou avez-vous identifié l'incident ?*",fontWeight: FontWeight.bold, fontSize: 16.0,),
                      SizedBox(height: 8,),
                      TextFormField(
                        controller: controller.txtLocalisationController,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Entrer le lieu svp';
                          if (value.length < 2) return 'Nom du lieu trop( 2 caractères au moins)';
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Ex: Marche, Mosquée, Mairie",
                            border: OutlineInputBorder(borderRadius:BorderRadius.circular(15)),
                            contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 12),
                            prefixIcon: Icon(Icons.place),
                            errorStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
                        ),
                      ),
                      SizedBox(height: 15,),
                      TextWidget(text: "Quand ?*",fontWeight: FontWeight.bold, fontSize: 16.0,),
                      SizedBox(height: 8,),
                      GestureDetector(
                        onTap: (){
                          controller.selectDateTime(context);
                        }, 
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: controller.txtDateController,
                            keyboardType: TextInputType.datetime,
                            validator: (value) {
                              if (value == null || value.isEmpty) return "Entrer le moment svp";
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Ex: Hier, à l'instant, à 16h30",
                                border: OutlineInputBorder(borderRadius:BorderRadius.circular(15)),
                                contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 12),
                                prefixIcon: Icon(Icons.calendar_today),
                                errorStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      TextWidget(text: "Description*",fontWeight: FontWeight.bold, fontSize: 16.0,),
                      SizedBox(height: 8,),
                      TextFormField(
                        controller: controller.txtDescriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) return "Entrer une description pour nous faciliter la tâche svp";
                          if (value.length < 8) return 'Description trop courte( 8 caractères au moins)';
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Précisez ici toutes les informations qui pourraient aider nos équipes",
                            border: OutlineInputBorder(borderRadius:BorderRadius.circular(15)),
                            errorStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
                        ),
                        maxLines: 10,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                      ),
                      SizedBox(height: 15,),
                      TextWidget(text: "Fichier(facultatif)",fontWeight: FontWeight.bold, fontSize: 16.0,),
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
                      SizedBox(height: 18,),
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
                            controller.checkEditForm();
                            if (controller.editFormIsValid.value == true) {
                              var data = {
                                'type': controller.selectedTypeAlerteModel.value.nom,
                                'localisation': controller.txtLocalisationController.text,
                                'date': controller.date_to_DB.value,
                                'description': controller.txtDescriptionController.text,
                                'fileUrl': controller.fileUrl.value != File('') ? controller.fileUrl.value : File(''),
                                'file_type': controller.isVideo.value == true ? 'video' : 'image',
                              };
                              controller.updateAlerte(controller.selectedAlerte.value.id, data);
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
                      SizedBox(height: 40.0,),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
