import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:jaime_cocody/app/data/repository/consultation_services.dart';
import 'package:jaime_cocody/app/models/consultation.dart';
import 'package:jaime_cocody/app/modules/auth/controllers/auth_controller.dart';
import 'package:jaime_cocody/app/modules/commerce/commerce_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../../../Utils/app_constantes.dart';
import '../../../Utils/app_routes.dart';
import '../../../controllers/main_controller.dart';
import '../../../data/repository/actualite_services.dart';
import '../../../data/repository/agenda_services.dart';
import '../../../data/repository/auth_service.dart';
import '../../../data/repository/data/api_status.dart';
import '../../../data/repository/diffusion_services.dart';
import '../../../data/repository/main_services.dart';
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

  var user_id = null;

  var isDataRefreshing = false.obs;

  final AuthController auth_ctrl = Get.put(AuthController());

  final MainController mainCtrl = Get.put(MainController());


  // final ActualiteController actualite_ctrl = Get.put(ActualiteController());
  // final CommerceController commerce_ctrl = Get.put(CommerceController());
  // final JobController job_ctrl = Get.put(JobController());
  // final PharmacieController pharm_ctrl = Get.put(PharmacieController());
  // final AlerteController alerte_ctrl = Get.put(AlerteController());
  // final AnnuaireController annuaire_ctrl = Get.put(AnnuaireController());
  // final HistoriqueController culture_ctrl = Get.put(HistoriqueController());
  // final DiffusionController bon_plan_ctrl = Get.put(DiffusionController());


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
      playSound();
      showNotificationSnackBar(event.notification!.title!, event.notification!.body!, event.data['click_action']);
      // Future.delayed(Duration(seconds: 20), (){
      //   showLocalNotification();
      // });
    });
  }

  // FIREBASE CLOUD MESSAGE ARRIERE PLAN
  void onMessageOpenedAppListen(){
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      playSound();
      // print("msg "+message.toString());
      showNotificationSnackBar(message.notification!.title!, message.notification!.body!, message.data['click_action']);
    });
    // Future.delayed(Duration(seconds: 20), (){
    //     showLocalNotification();
    // });
  }

   refreshData() async {
    await mainCtrl.checkAppName();

    SharedPreferences storage = await SharedPreferences.getInstance();
    user_id = storage.getInt('user_id');
    // print('cloud token '+storage.getString('cloud_messaging_token').toString());
    // print('user auth id '+user_id.toString());
    await isDataRefreshing(true);
    await mainCtrl.isCocody.value == true ? checkIfAccountis_actif() : null;

    await getUnReadItemsCounts();
    await getUnReadDiffusionCount();
    await isDataRefreshing(false);
    await checkUpdate(user_id);
  }

  refreshHome() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    user_id = storage.getInt('user_id');

    await isDataRefreshing(true);
    await mainCtrl.isCocody.value == true ? checkIfAccountis_actif() : null;

    await getUnReadItemsCounts();
    await getUnReadDiffusionCount();
    await isDataRefreshing(false);
    await mainCtrl.isCocody.value == true ? checkUpdate(user_id) : null;
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
  checkIfAccountis_actif() async{
    await auth_ctrl.loadAuthInfo();
    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      // print('check account user id '+ auth_ctrl.getUserId.toString());
      await checkUpdate(auth_ctrl.getUserId);
      await getAuthUserInfo(auth_ctrl.getUserId);

      if(auth_user.id == null || auth_user.id == 0 || auth_user.is_actif == 0 || auth_user.is_actif == null){
        await resetUserInfo();
        Get.offNamed(AppRoutes.AUTH);
      }
    }
  }

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
   // LOCAL NOTIF
  void showLocalNotification(){
    playSound();
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

  }


  var miseAJourModel = MiseAJourModel().obs;

  var showUpdateWidget = true.obs;

  closeUpdateWidget(){
    showUpdateWidget(false);
  }

  // CHECK UPDATE
  checkUpdate(user_id) async{
    // print(user_id);
    try{
      final response = await MainServices.checkUpdate(user_id);
      if(response is Success){
        miseAJourModel = MiseAJourModel().obs;
        miseAJourModel.value = response.response as MiseAJourModel;
        // print(miseAJourModel.value.toString());
      }
      if(response is Failure){
        // print("error de mis a jour "+response.toString());
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

  var tokenTimer;
  checkCloudMessagingTokenInTime() async{
    tokenTimer = Timer.periodic(Duration(seconds: 8), (timer) async {
      await checkCloudMessagingToken();
    });
  }

  checkCloudMessagingToken()async{
    SharedPreferences storage = await SharedPreferences.getInstance();
    var cloud_messaging_token = storage.getString('cloud_messaging_token');
    if(cloud_messaging_token == null || cloud_messaging_token == ''){
        await setCloudMessagingToken();
    }
  }
  // FIREBASE CLOUD MESSAGING CONFIGURATION
  String token = '';
  getToken() async {
    token = (await FirebaseMessaging.instance.getToken())!;
  }

  setCloudMessagingToken() async{
    await getToken();
    try{
      final response = await MainServices.setUserCloudMessagingToken(user_id, token);
      if(response is Success){
        // refresh();
      }
      if(response is Failure){
        // isDataProcessing(false);
        // print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      // isDataProcessing(false);
      // print("Exception  "+ex.toString());
    }
  }


  @override
  void onInit() {
    super.onInit();
    // MAKE APP NEW VERSION UPDATE AUTO
    checkAppForUpdate();

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
    // checkNewVersion();
  }


  @override
  void onReady() {
    super.onReady();
    // IN REAL TIME
    getUnReadItemsCountsInRealTime();
    // CHECK CLOUD TOKEN
    checkCloudMessagingTokenInTime();
  }

  @override
  void onClose() {
    timer?.cancel();

    refreshData();

    _connectivitySubscription.cancel();
    // checkUpdate();
  }


  /* CHECK UPDATE FOR PACKAGE NEW VERSION */
    // // CHECK UPDATE
    // checkNewVersion() async{
    //   // Instantiate NewVersion manager object (Using GCP Console app as example)
    //   final newVersion = NewVersion(
    //     // iOSId: 'com.google.Vespa',
    //     // androidId: 'com.google.android.apps.cloudconsole',
    //     androidId: 'com.siriusntech.jaime_cocody',
    //   );
    //
    //   await advancedStatusCheck(newVersion);
    //
    //   // // You can let the plugin handle fetching the status and showing a dialog,
    //   // // or you can fetch the status and display your own dialog, or no dialog.
    //   // const simpleBehavior = true;
    //   //
    //   // if (simpleBehavior) {
    //   //   basicStatusCheck(newVersion);
    //   // } else {
    //   //   advancedStatusCheck(newVersion);
    //   // }
    // }
    //
    // basicStatusCheck(NewVersion newVersion) {
    //   newVersion.showAlertIfNecessary(context: Get.context!);
    // }
    //
    // advancedStatusCheck(NewVersion newVersion) async {
    //   final status = await newVersion.getVersionStatus();
    //   if (status != null) {
    //     newVersion.showUpdateDialog(
    //       context: Get.context!,
    //       versionStatus: status,
    //       dialogTitle: 'Mise à jour',
    //       dialogText: 'Nouvelles fonctionnalités disponible',
    //       updateButtonText: 'Effectuer la mise à jour',
    //       allowDismissal: false,
    //       dismissButtonText: 'Annuler',
    //       dismissAction: () => functionToRunAfterDialogDismissed(),
    //     );
    //   }
    // }
    //
    // functionToRunAfterDialogDismissed(){
    //   Get.back();
    // }
  /* END CHECK UPDATE FOR PACKAGE NEW VERSION */

  /* CHECK UPDATE FOR PACKAGE in_app_update */
      AppUpdateInfo? updateInfo;

      // Platform messages are asynchronous, so we initialize in an async method.
      Future<void> checkAppForUpdate() async {
        InAppUpdate.checkForUpdate().then((info) {
          updateInfo = info;
          updateApp();
        }).catchError((e) {
          print("in_app_update check update error "+e.toString());
        });
      }
      updateApp(){
        updateInfo?.updateAvailability == UpdateAvailability.updateAvailable
            ? () {
            InAppUpdate.startFlexibleUpdate().then((_) {

          }).catchError((e) {
              print("in_app_update make update error "+e.toString());
          });
        } : null;
      }
  /* END CHECK UPDATE FOR PACKAGE in_app_update */

  // Share app
  void ShareAppLink() async{
    Share.share('https://siriusntech.com/app/jaime_cocody', subject: "Application J'aime Cocody");
  }

  // ADD VISITE
  addVisiteCount(module) async{
    try{
      final response = await MainServices.addVisiteCount(module, user_id);
      if(response is Success){
        // refresh();
      }
      if(response is Failure){
        // isDataProcessing(false);
        // print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      // isDataProcessing(false);
      // print("Exception  "+ex.toString());
    }
  }

}
