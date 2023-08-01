import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/app_constantes.dart';
import '../../../Utils/app_routes.dart';
import '../../../widgets/alerte_widgets.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
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
              mainColorYakro,
            ],
          )),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Stack(
              // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              children: [HomePage()],
            ),
          ),
        ));
  }
}

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AuthController authController = Get.put(AuthController());
  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;

  _textFileOtp(BuildContext context,
      {bool first = true, bool last = false, ctrl, FocusNode? focus}) {
    return Container(
      height: 85,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: AspectRatio(
        aspectRatio: 0.7,
        child: TextFormField(
          focusNode: focus,
          controller: ctrl,
          validator: (value) {
            if (value == null || value.isEmpty) return "";
            return null;
          },
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
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
                borderRadius: BorderRadius.circular(12)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
  _stepTwoCard(BuildContext context) {
    return Obx(() => Container(
          padding: EdgeInsets.all(8),
          width: double.infinity,
          height: 230,
          child: Card(
            elevation: 50,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextWidget(
                  text: "Veuillez entrer le code réçu par SMS",
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  alignement: TextAlign.center,
                  scaleFactor: 1.3,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: _textFileOtp(context,
                              first: true,
                              last: false,
                              ctrl: authController.txtCode_1,
                              focus: authController.code_1FocusNode)),
                      Flexible(
                          child: _textFileOtp(context,
                              first: false,
                              last: false,
                              ctrl: authController.txtCode_2,
                              focus: authController.code_2FocusNode)),
                      Flexible(
                          child: _textFileOtp(context,
                              first: false,
                              last: false,
                              ctrl: authController.txtCode_3,
                              focus: authController.code_3FocusNode)),
                      Flexible(
                          child: _textFileOtp(context,
                              first: false,
                              last: true,
                              ctrl: authController.txtCode_4,
                              focus: authController.code_4FocusNode)),
                    ],
                  ),
                )),
                authController.isProcessing.value
                    ? SpinKitFadingCircle(
                        color: AppColors.mainColor,
                        size: 60.0,
                      )
                    : Expanded(
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  StadiumBorder()),
                            ),
                            onPressed: () {
                              authController.initTextFields(context);
                              authController.setStep(1);
                            },
                            child: TextWidget(
                                text: "<< Précédent",
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              authController.checkForm();
                              authController.txtCodeController.text =
                                  authController.txtCode_1.text +
                                      authController.txtCode_2.text +
                                      authController.txtCode_3.text +
                                      authController.txtCode_4.text;

                              if (authController.user.value.code !=
                                  int.parse(
                                      authController.txtCodeController.text)) {
                                showAlerte('Information',
                                    'Code invalide, veuillez réessayer svp');
                                authController.initTextFields(context);
                                return null;
                              }
                              var data = {
                                "contact":
                                    authController.txtContactController.text,
                                "code": authController.txtCodeController.text,
                                "cloud_messaging_token":
                                    authController.cloud_messaging_token
                              };
                              authController.confirm(data);
                            },
                            child: TextWidget(
                              text: "Confirmation",
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              alignement: TextAlign.center,
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(mainColor),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  StadiumBorder()),
                            ),
                          ),
                        ],
                      ))
              ],
            ),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 7,
      ),
    );
    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });
    animation2 = Tween<double>(begin: .02, end: .04).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    controller2 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    animation3 = Tween<double>(begin: .41, end: .38).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });
    animation4 = Tween<double>(begin: 170, end: 190).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    Timer(Duration(milliseconds: 2500), () {
      controller1.forward();
    });

    controller2.forward();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.vert_color_fonce,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Positioned(
                  top: size.height * (animation2.value + .58),
                  left: size.width * .21,
                  child: CustomPaint(
                    painter: MyPainter(50),
                  ),
                ),
                Positioned(
                  top: size.height * .98,
                  left: size.width * .1,
                  child: CustomPaint(
                    painter: MyPainter(animation4.value - 30),
                  ),
                ),
                Positioned(
                  top: size.height * .5,
                  left: size.width * (animation2.value + .8),
                  child: CustomPaint(
                    painter: MyPainter(30),
                  ),
                ),
                Positioned(
                  top: size.height * animation3.value,
                  left: size.width * (animation1.value + .1),
                  child: CustomPaint(
                    painter: MyPainter(60),
                  ),
                ),
                Positioned(
                  top: size.height * .1,
                  left: size.width * .8,
                  child: CustomPaint(
                    painter: MyPainter(animation4.value),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      height: 160,
                      child: Image(
                        image: AssetImage(LOGO_BLANC),
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    TextWidget(
                      text:
                          "Explorez les trésors de votre commune avec cette application mobile !",
                      color: Colors.white,
                      scaleFactor: 1.2,
                      fontSize: 16,
                      alignement: TextAlign.center,
                      fontWeight: FontWeight.w600,
                    ),
                    Expanded(
                      flex: -1,
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * 0.02),
                        child: Text(
                          'J\'aime Yakro',
                          style: TextStyle(
                            color: Colors.white.withOpacity(.7),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            wordSpacing: 4,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                 
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Politique de confidentialité
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Form(
                                key: authController.formkey,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: Obx(() => authController.step.value == 1
                                    ? component()
                                    : _stepTwoCard(context))),
                          ),
                          SizedBox(width: size.width / 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget component() {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaY: 15,
                sigmaX: 15,
              ),
              child: Container(
                height: size.width / 6,
                width: size.width / 1.3,
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: size.width / 30),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.05),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: authController.txtPseudoController,
                  validator: (value) {
                    return authController.validPseudo(value);
                  },
                  style: TextStyle(color: Colors.white.withOpacity(.8)),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.white.withOpacity(.7),
                      ),
                      border: InputBorder.none,
                      hintMaxLines: 1,
                      hintText: "Votre nom d\'utilisateur...",
                      hintStyle: TextStyle(
                          fontSize: 18, color: Colors.white.withOpacity(.5)),
                      errorStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaY: 15,
                sigmaX: 15,
              ),
              child: Container(
                height: size.width / 6,
                width: size.width / 1.3,
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: size.width / 30),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.05),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: authController.txtContactController,
                  validator: (value) {
                    return authController.validContact(value);
                  },
                  style: TextStyle(color: Colors.white.withOpacity(.8)),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone_android_rounded,
                        color: Colors.white.withOpacity(.7),
                      ),
                      border: InputBorder.none,
                      hintMaxLines: 1,
                      hintText: 'Numéro de téléphone...',
                      hintStyle: TextStyle(
                          fontSize: 18, color: Colors.white.withOpacity(.5)),
                      errorStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          Center(
            child: Column(
              children: [
                SizedBox(height: 5.0),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.CONDITION);
                  },
                  child: TextWidget(
                    text:
                        "Lire la politique de confidentialité et les conditions d'utilisations.",
                    color: AppColors.rouge_doux,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    alignement: TextAlign.center,
                  ),
                ),
                SizedBox(height: 7.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Obx(() => Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.all<Color>(
                                authController.getColor()),
                            value: authController.isChecked.value,
                            onChanged: (value) {
                              authController.accepteConditions(value!);
                            },
                          )),
                    ),
                    Flexible(
                        flex: 3,
                        child: TextWidget(
                          text:
                              "J'accepte la politique de confidentialité et les conditions d'utilisations.",
                          color: AppColors.appbarTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () async {
                  HapticFeedback.lightImpact();
                  final data = {
                    "contact": authController.txtContactController.text,
                    "pseudo": authController.txtPseudoController.text,
                    "cloud_messaging_token":
                        authController.cloud_messaging_token
                  };
                  // Pour l'enregistrement
                    // authController.register(data);
                   if (authController.isValid()) {
                      authController.register(data);
                       Fluttertoast.showToast(
                      msg: 'Vivez des moments inoubliables!');
                   }else{
                     Fluttertoast.showToast(
                      msg: 'Vueillez remplir tous les champs!');
                   }
               
                },
                child: Container(
                  height: size.width / 8,
                  width: size.width / 2.6,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.05),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Suivant >>',
                    style: TextStyle(
                        color: Colors.white.withOpacity(.8),
                        fontWeight: FontWeight.w400,
                        fontSize: 17),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double radius;

  MyPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
              colors: [AppColors.vert_color, AppColors.vert_colorFonce],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)
          .createShader(Rect.fromCircle(
        center: Offset(0, 0),
        radius: radius,
      ));

    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
