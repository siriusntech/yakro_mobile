import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:jaime_cocody/app/data/repository/consultation_services.dart';
import 'package:jaime_cocody/app/models/consultation.dart';
import 'package:jaime_cocody/app/modules/auth/controllers/auth_controller.dart';
import 'package:jaime_cocody/app/modules/commerce/commerce_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../../../Utils/app_constantes.dart';
import '../../../Utils/app_routes.dart';
import '../../../data/repository/actualite_services.dart';
import '../../../data/repository/agenda_services.dart';
import '../../../data/repository/alerte_services.dart';
import '../../../data/repository/annuaire_services.dart';
import '../../../data/repository/auth_service.dart';
import '../../../data/repository/data/api_status.dart';
import '../../../data/repository/diffusion_services.dart';
import '../../../data/repository/discussion_services.dart';
import '../../../data/repository/historique_services.dart';
import '../../../data/repository/main_services.dart';
import '../../../data/repository/pharmacie_services.dart';
import '../../../models/mise_a_jour_model.dart';
import '../../../widgets/alerte_widgets.dart';
import '../../actualite/actualite_model.dart';
import '../../agenda/agenda_model.dart';
import '../../auth/user_model.dart';
import '../../commerce/commerce_services.dart';
import '../../diffusion/diffusion_model.dart';

class HomeController extends GetxController {

  var unReadItemsCountsList = List<Consultation>.empty(growable: true).obs;

  var selectedItemsCounts = Consultation().obs;

  var unReadCommerceCount = 0.obs;
  var unReadAgendaCount = 0.obs;
  var unReadActualiteCount = 0.obs;
  var unReadDiffusionCount = 0.obs;
  var unReadDiscussionCount = 0.obs;
  var unReadAlerteCount = 0.obs;
  var unReadSujetCount = 0.obs;

  var  auth_user = User();

  var isDataRefreshing = false.obs;

  final AuthController auth_ctrl = Get.put(AuthController());
  // final ActualiteController actualite_ctrl = Get.put(ActualiteController());
  // final CommerceController commerce_ctrl = Get.put(CommerceController());
  // final HistoriqueController auth_ctrl = Get.put(AuthController());
  // final AuthController auth_ctrl = Get.put(AuthController());





  // SET USER ACCOUNT INFO
  resetUserInfo() async{
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setInt('user_id', 0);
    storage.setInt('is_actif', 0);
    // storage.setString('token', '');
    // ignore: deprecated_member_use
    storage.commit();
  }

  getAuthUserInfo(user_id) async{
    try{
      final response = await AuthService.getUser(user_id);
      if(response is Success){
        auth_user = response.response as User;
      }
      if(response is Failure){
        print("Erreur get user info: "+response.errorResponse.toString());
      }
    }catch(ex){
      print("Exception get user info: "+ex.toString());
    }
  }

  // GET UNREAD ITEMS COUNTS
  getUnReadItemsCounts() async{
    try{
      final response = await ConsultationServices.getAllUnreadsCounts();
      if(response is Success){
        selectedItemsCounts.value = Consultation();
        selectedItemsCounts.value = response.response as Consultation;
      }
      if(response is Failure){
        selectedItemsCounts.value.un_read_agenda_count = 0;
        selectedItemsCounts.value.un_read_alerte_count = 0;
        selectedItemsCounts.value.un_read_actualite_count = 0;
        selectedItemsCounts.value.un_read_commerce_count = 0;
        selectedItemsCounts.value.un_read_discussion_count = 0;
        selectedItemsCounts.value.un_read_sujet_count = 0;
      }
    }catch(ex){
       print("getUnReadItemsCounts Error "+ex.toString());
    }
  }

  // GET UNREAD COMMERCE COUNT
  void getUnReadCommerceCount() async{
      try{
        final response = await CommerceServices.getUnReadCommerces();
        if(response is Success){
          final comList = response.response as List<Commerce>;
          unReadCommerceCount.value = comList.length;
        }
        if(response is Failure){
          unReadCommerceCount.value = 0;
        }
      }catch(ex){
        unReadCommerceCount.value = 0;
      }
  }
  // GET UNREAD DIFFUSION COUNT
  getUnReadDiffusionCount() async{
    try{
      final response = await DiffusionServices.getUnReadDiffusions();
      if(response is Success){
        unReadDiffusionCount.value = 0;
        final comList = response.response as List<Diffusion>;
        unReadDiffusionCount.value = comList.length;
      }
      if(response is Failure){
        unReadDiffusionCount.value = 0;
      }
    }catch(ex){
      unReadDiffusionCount.value = 0;
    }
  }
  // GET UNREAD AGENDA COUNT
  void getUnReadAgendaCount() async{
    try{
      final response = await AgendaServices.getUnReadAgendas();
      if(response is Success){
        final comList = response.response as List<Agenda>;
        unReadAgendaCount.value = comList.length;
      }
      if(response is Failure){
        unReadAgendaCount.value = 0;
      }
    }catch(ex){
      unReadAgendaCount.value = 0;
    }
  }
  // GET UNREAD ACTUALITE COUNT
  void getUnReadActualiteCount() async{
    try{
      final response = await ActualiteServices.getUnReadActualites();
      if(response is Success){
        final comList = response.response as List<Actualite>;
        unReadActualiteCount.value = comList.length;
      }
      if(response is Failure){
        unReadActualiteCount.value = 0;
      }
    }catch(ex){
      unReadActualiteCount.value = 0;
    }
  }


  var timer;

  getUnReadItemsCountsInRealTime()  async{
    timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      // print('hello');
     await getUnReadItemsCounts();
     await getUnReadDiffusionCount();
    });
  }



  // FIREBASE CLOUD MESSAGE AVANT PLAN
  void onMessageListen(){
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      showNotificationSnackBar(event.notification!.title!, event.notification!.body!, event.data['click_action']);
      // Future.delayed(Duration(seconds: 20), (){
      //   showLocalNotification();
      // });
    });
  }
  // FIREBASE CLOUD MESSAGE ARRIERE PLAN
  void onMessageOpenedAppListen(){
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // print("msg "+message.toString());
      showNotificationSnackBar(message.notification!.title!, message.notification!.body!, message.data['click_action']);
    });
    // Future.delayed(Duration(seconds: 20), (){
    //     showLocalNotification();
    // });
  }
   refreshData() async {
    await isDataRefreshing(true);
    await checkIfAccountIsActif();

    await getUnReadItemsCounts();
    await getUnReadDiffusionCount();
    await isDataRefreshing(false);
  }

  var connectivityResult;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  checkConnexion() async{
    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      print('Connected');
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      print('Connected');
    }else{
      showSnackBar("Erreur de connexion", "Aucune connexion internet", Colors.red);
    }
  }

  observeConnexion(ConnectivityResult result){
    connectivityResult = result;
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      print('obs Connected');
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      print('obs Connected');
    }else{
      showSnackBar("Erreur de connexion", "Aucune connexion internet", Colors.red);
    }
  }

  // CHECK USER ACCOUNT
  checkIfAccountIsActif() async{
    await auth_ctrl.loadAuthInfo();
    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      // print('check account user id '+ auth_ctrl.getUserId.toString());
      await checkUpdate(auth_ctrl.getUserId);
      await getAuthUserInfo(auth_ctrl.getUserId);

      if(auth_user.id == null || auth_user.id == 0 || auth_user.isActif == 0 || auth_user.isActif == null){
        await resetUserInfo();
        Get.offNamed(AppRoutes.AUTH);
      }
    }
  }

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
   // LOCAL NOTIF
  void showLocalNotification(){
    var initializationSettingsAndroid = new AndroidInitializationSettings('ic_launcher');
    var initialzationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: onSelectNotification,
        onDidReceiveNotificationResponse: onSelectNotification);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: mainColor,
                // TODO add a proper drawable resource to android, for now using
                // one that already exists in example app.
                icon: "@mipmap/ic_launcher",
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showNotificationSnackBar(message.notification!.title!, message.notification!.body!, message.data['click_action']);
      }
    });

    getToken();
  }

  void onSelectNotification(payload){
     print('payload '+ payload);
  }

  var miseAJourModel = MiseAJourModel().obs;

  var showUpdateWidget = true.obs;

  closeUpdateWidget(){
    showUpdateWidget(false);
  }

  // CHECK UPDATE
  checkUpdate(user_id) async{
    try{
      final response = await MainServices.checkUpdate(user_id);
      if(response is Success){
        miseAJourModel = MiseAJourModel().obs;
        miseAJourModel.value = response.response as MiseAJourModel;
      }
      if(response is Failure){

      }
    }catch(ex){

    }
  }
  // MAKE UPDATE
  makeUpdate() async{
    try{
      final response = await MainServices.makeUpdate(auth_ctrl.getUserId);
      if(response is Success){
        miseAJourModel = MiseAJourModel().obs;
        miseAJourModel.value = response.response as MiseAJourModel;
        showUpdateWidget(false);
      }
      if(response is Failure){

      }
    }catch(ex){

    }
  }


  @override
  void onInit() {
    super.onInit();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // GetConnectionType();
    // _streamSubscription = _connectivity.onConnectivityChanged.listen(_updateState);
    checkConnexion();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      observeConnexion(result);
    });

    refreshData();

    onMessageListen();
    onMessageOpenedAppListen();


    // checkUpdate();

  }

  String token = '';
  getToken() async {
    token = (await FirebaseMessaging.instance.getToken())!;
  }

  @override
  void onReady() {
    super.onReady();
    // IN REAL TIME
    getUnReadItemsCountsInRealTime();
  }

  @override
  void onClose() {
    timer?.cancel();

    refreshData();

    _connectivitySubscription.cancel();
    // checkUpdate();
  }

  // // Share app
  // void ShareApp() async{
  //   final bytes = await rootBundle.load('assets/apk/contactup.apk');
  //   final list = bytes.buffer.asUint8List();
  //
  //   final tempDir = await getTemporaryDirectory();
  //   final file = await File('${tempDir.path}/contactup.apk').create();
  //   file.writeAsBytesSync(list);
  //
  //   Share.shareFiles([(file.path)]);
  // }

  // Share app
  void ShareAppLink() async{
    Share.share('https://siriusntech.com/app/jaime_cocody', subject: "Application J'aime Cocody");
  }

  // ADD VISITE
  addActualiteVisiteCount() async{
    try{
      final response = await ActualiteServices.addActualiteVisite();
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
  // ADD VISITE
  addAgendaVisiteCount() async{
    try{
      final response = await AgendaServices.addAgendaVisite();
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
  // ADD VISITE
  addAlerteVisiteCount() async{
    try{
      final response = await AlerteServices.addAlerteVisite();
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
  // ADD VISITE
  addAnnuaireVisiteCount() async{
    try{
      final response = await AnnuaireServices.addAnnuaireVisite();
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

  // ADD VISITE
  addCommerceVisiteCount() async{
    try{
      final response = await CommerceServices.addCommerceVisite();
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
  // ADD VISITE
  addDiffusionVisiteCount() async{
    try{
      final response = await DiffusionServices.addBonPlanVisite();
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
  // ADD VISITE
  addDiscussionVisiteCount() async{
    try{
      final response = await DiscussionServices.addDiscussionVisite();
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
  // ADD VISITE
  addHistoriqueVisiteCount() async{
    try{
      final response = await HistoriqueServices.addHistoriqueVisite();
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

  // ADD VISITE
  addPharmacieVisiteCount() async{
    try{
      final response = await PharmacieServices.addPharmacieVisite();
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

}
