import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:jaime_cocody/app/Utils/app_colors.dart';
import 'package:jaime_cocody/app/widgets/alerte_widgets.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/app_routes.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {


  _stepOneCard(BuildContext context){
    return Obx(() => Container(
      width: double.infinity,
      height: 330,
      child: Card(
        color: Colors.white,
        elevation: 50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: TextWidget(text: "Pseudo", fontSize: 15.0, fontWeight: FontWeight.w600,scaleFactor: 1.2, alignement: TextAlign.center,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                  child: TextFormField(
                    controller: controller.txtPseudoController,
                    validator: (value) {
                      return controller.validPseudo(value);
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.all(10.0),
                        prefixIcon: Icon(Icons.person) ,
                        hintText: "Nom utilisateur",
                        errorStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
                    ),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: TextWidget(text: "Numéro de téléphone", fontSize: 15.0, fontWeight: FontWeight.w600,scaleFactor: 1.2, alignement: TextAlign.center,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                  child: TextFormField(
                    controller: controller.txtContactController,
                    validator: (value) {
                      return controller.validContact(value);
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.all(10.0),
                        prefixIcon: Icon(Icons.phone),
                        hintText: "0123456789",
                        errorStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
                    ),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Center(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Get.toNamed(AppRoutes.CONDITION);
                        },
                        child: TextWidget(text: "Lire la politique de confidentialité et les conditions d'utilisations.",
                          color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold, alignement: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Obx(() => Checkbox(
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.all<Color>(controller.getColor()),
                              value: controller.isChecked.value,
                              onChanged: (value) {
                                controller.accepteConditions(value!);
                              },
                            )),
                          ),
                          Flexible(
                              flex: 5,
                              child: TextWidget(text: "J'accepte la politique de confidentialité et les conditions d'utilisations.",
                                color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold,
                              )
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 4,),
                Center(
                  child: SizedBox(
                    width: 130,
                    height: 40,
                    child: controller.isProcessing.value ?
                    SpinKitFadingCircle(
                      color: AppColors.mainColor,
                      size: 60.0,
                    ) : ElevatedButton(
                      onPressed: () async{
                        final data = {"contact":
                        controller.txtContactController.text,
                          "pseudo": controller.txtPseudoController.text,
                          "cloud_messaging_token": controller.cloud_messaging_token
                        };
                        controller.register(data);
                      },
                      child: TextWidget(text: "Suivant  >>",color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold, alignement: TextAlign.center,),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(mainColor),
                        shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
  _stepTwoCard(BuildContext context){
    return Obx(() => Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      height: 230,
      child: Card(
        elevation: 50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextWidget(text: "Veuillez entrer le code réçu par SMS",
              fontSize: 16.0, fontWeight: FontWeight.bold,
              alignement: TextAlign.center, scaleFactor: 1.3,),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: _textFileOtp(context, first: true, last: false, ctrl: controller.txtCode_1, focus: controller.code_1FocusNode)),
                  Flexible(child: _textFileOtp(context, first: false, last: false, ctrl: controller.txtCode_2, focus: controller.code_2FocusNode)),
                  Flexible(child: _textFileOtp(context, first: false, last: false, ctrl: controller.txtCode_3, focus: controller.code_3FocusNode)),
                  Flexible(child: _textFileOtp(context, first: false, last: true, ctrl: controller.txtCode_4, focus: controller.code_4FocusNode)),
                ],
              ),
            )),
            controller.isProcessing.value ?
            SpinKitFadingCircle(
              color: AppColors.mainColor,
              size: 60.0,
            ) :
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                    shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                  ),
                  onPressed: (){
                    controller.initTextFields(context);
                    controller.setStep(1);
                  },
                  child: TextWidget(text: "<< Précédent", fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                SizedBox(width: 8,),
                ElevatedButton(
                  onPressed: (){
                    controller.checkForm();
                    controller.txtCodeController.text = controller.txtCode_1.text + controller.txtCode_2.text + controller.txtCode_3.text + controller.txtCode_4.text;

                    if(controller.user.value.code != int.parse(controller.txtCodeController.text)){
                      showAlerte('Information', 'Code invalide, veuillez réessayer svp');
                      controller.initTextFields(context);
                      return null;
                    }
                    var data = {
                      "contact": controller.txtContactController.text,
                      "code": controller.txtCodeController.text,
                      "cloud_messaging_token": controller.cloud_messaging_token
                    };
                    controller.confirm(data);
                  },
                  child: TextWidget(text: "Confirmation",color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold, alignement: TextAlign.center,),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(mainColor),
                    shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    ));
  }
  _textFileOtp(BuildContext context,{bool first=true, bool last=false, ctrl, FocusNode? focus}){

    return Container(
      height: 85,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: AspectRatio(
        aspectRatio: 0.7,
        child: TextFormField(
          focusNode: focus,
          controller: ctrl,
          validator: (value){
            if(value == null || value.isEmpty) return "";
            return null;
          },
          autofocus: true,
          onChanged: (value){
            if(value.length == 1 && last == false){
              FocusScope.of(context).nextFocus();
            }
            if(value.length == 0 && first == false){
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black12),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(12)
            ),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(12)
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: settingsCtrl.appbarColorFromCode,
        // backgroundColor: settingsCtrl.appbarColorFromCode,
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   title: Text(""),
        //   backgroundColor: settingsCtrl.appbarColorFromCode,
        //   elevation: 0.0,
        //   automaticallyImplyLeading: false,
        // ),
        body: Container(
          decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              AppColors.secondaryColorFromCode,
              mainColor,
             ],
            )
          ),
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: ListView(
              // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              children: [
                Container(
                  padding: EdgeInsets.only(top: 15, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        height: 170,
                        child: Image(
                          image: AssetImage(LOGO_BLANC),
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      TextWidget(text: "Bienvenue sur l'application mobile de la commune", color: Colors.white,
                        scaleFactor: 1.2, fontSize: 18, alignement: TextAlign.center, fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 15,)
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Form(
                      key: controller.formkey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Obx(() => controller.step.value == 1 ? _stepOneCard(context) : _stepTwoCard(context))
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
