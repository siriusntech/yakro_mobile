import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jaime_cocody/app/Utils/app_routes.dart';

import '../../../data/repository/auth_service.dart';
import '../../../data/repository/data/api_status.dart';
import '../user_model.dart';
import '../../../widgets/alerte_widgets.dart';

class AuthController extends GetxController {

  var  user_id = 0.obs;
  var  code = 0.obs;
  var  is_actif = 0.obs;

  var  token = ''.obs;
  var  nom = ''.obs;
  var  prenom = ''.obs;
  var  pseudo = ''.obs;
  var  email = ''.obs;
  var  contact = ''.obs;

  String cloud_messaging_token = "";

  get getUserId => user_id.value;
  get getUserToken => token.value;
  get getUserPseudo => pseudo.value;
  get getUserNom => nom.value;
  get getUserPrenom => prenom.value;
  get getUserEmail => email.value;
  get getUserContact => contact.value;
  get getUseris_actif => is_actif.value;
  get getUserCode => code.value;

  var  user = User().obs;
  var usersList = List<User>.empty(growable: true).obs;

  final formkey = GlobalKey<FormState>();

  final TextEditingController txtContactController = TextEditingController();
  final TextEditingController txtPseudoController = TextEditingController();

  final TextEditingController txtCodeController = TextEditingController();

  final TextEditingController txtCode_1 = TextEditingController();
  final TextEditingController txtCode_2 = TextEditingController();
  final TextEditingController txtCode_3 = TextEditingController();
  final TextEditingController txtCode_4 = TextEditingController();

  FocusNode code_1FocusNode = new FocusNode();
  FocusNode code_2FocusNode = new FocusNode();
  FocusNode code_3FocusNode = new FocusNode();
  FocusNode code_4FocusNode = new FocusNode();

  var step = 1.obs;
  var isProcessing = false.obs;

  var condition_of_use = """J'aime Cocody est une application qui permet de mieux connaitre la commune à travers son histoire et être informé de toutes les actualités la concernant.
  Elle permet aussi aux habitants d'échanger et donner leur avis sur tous ce qui concerne la commune à travers des discussions ou forums.
  Vous pouvez aussi trouver tous les espaces importants de la commune tels que les pharmacies de garde, commerces, restaurants et autres.
   Il est interdits d'utiliser les mots inappropriés comme les injures et propos haineux sous peine de voir son compte bloqué.
  """;

  var politique = """La connexion se fait avec un pseudo(quelconque) et votre numéro de téléphone et en une seule fois, 
  c'est à dire que la connexion est unique sans possibilité de modifier ses informations de connexion. 
  Il n'y a pas d'espace pour accès à son profil dans l'application.""";

  var isChecked = false.obs;

  Color getColor() {
    return isChecked.value == true ? Colors.blue : Colors.red;
  }

  accepteConditions(bool cond){
    isChecked.value = cond;
  }


  onLoad() async{
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.clear();
  }


  checkPseudo() async{
    await getUsers();
    var userIndex = -1;
    userIndex = usersList.indexWhere((element) => element.pseudo == txtPseudoController.text);
    if(userIndex != -1){
      final User user = usersList[userIndex];
      if(user.contact != txtContactController.text){
        // print(user.contact);
        // print(txtContactController.text);
        return true;
      }else{
        return false;
      }
    } else {
      return false;
    }
  }
  checkis_actif(pseudo) async{
    await getUsers();
    var userIndex = -1;
    userIndex = usersList.indexWhere((element) => element.pseudo == pseudo);
    if(userIndex != -1){ // IF PSEUDO EXISTE
      final User user = usersList[userIndex];
      if(user.contact == txtContactController.text){
        if(user.is_actif == 1){
          return true;
        }else{
          return false;
        }
      }
    }else{
      return true;
    }
  }

  setStep(stp) => step.value = stp;

  initTextFields(BuildContext context){
    txtCode_4.clear();
    txtCode_3.clear();
    txtCode_2.clear();
    txtCode_1.clear();
    txtCodeController.clear();
    FocusScope.of(context).requestFocus(code_1FocusNode);
  }

  resetUserInfo() async{
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setInt('user_id', 0);
    storage.setInt('code', 0);
    storage.setInt('is_actif', 0);
    storage.setString('token', '');
    storage.setString('nom', '');
    storage.setString('prenom', '');
    storage.setString('pseudo', '');
    storage.setString('email', '');
    storage.setString('contact', '');
    // ignore: deprecated_member_use
    storage.commit();
  }

  iniAuthInfo() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setInt('user_id', user.value.id ?? 0);
    storage.setInt('code', user.value.code ?? 0);
    storage.setInt('is_actif', user.value.is_actif ?? 0);
    storage.setString('token', user.value.token ?? '');
    storage.setString('nom', user.value.nom ?? '');
    storage.setString('prenom', user.value.prenom ?? '');
    storage.setString('pseudo', user.value.pseudo ?? '');
    storage.setString('email', user.value.email ?? '');
    storage.setString('contact', user.value.contact ?? '');
    // ignore: deprecated_member_use
    storage.commit();
  }

  loadAuthInfo() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    setUserId(storage.getInt('user_id'));
    setCode(storage.getInt('code'));
    setis_actif(storage.getInt('is_actif'));
    setToken(storage.getString('token'));
    setNom(storage.getString('nom'));
    setPrenom(storage.getString('prenom'));
    setPseudo(storage.getString('pseudo'));
    setEmail(storage.getString('email'));
    setContact(storage.getString('contact'));
  }


  setUsersList(List<User> p_users){
    usersList.addAll(p_users);
  }
  setUserId(int? p_id){
    user_id.value = p_id != null ? p_id : 0;
    // print('id '+user_id.value.toString());
  }
  setCode(int? p_code){
    code.value = p_code != null ? p_code : 0;
  }
  setis_actif(int? p_actif) async{
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setInt('is_actif', p_actif != null ? p_actif : 0);
    is_actif.value = p_actif != null ? p_actif : 0;
    // print('is actif '+is_actif.value.toString());
  }
  setToken(String? p_token){
    token.value = p_token != null ? p_token : '';
  }
  setNom(String? p_nom) async{
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString('nom', p_nom != null ? p_nom : '');
    nom.value = p_nom != null ? p_nom : '';
  }
  setPrenom(String? p_prenom) async{
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString('prenom', p_prenom != null ? p_prenom : '');
    prenom.value = p_prenom != null ? p_prenom : '';
  }
  setPseudo(String? p_pseudo){
    pseudo.value = p_pseudo != null ? p_pseudo : '';
  }
  setEmail(String? p_email) async{
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString('email', p_email != null ? p_email : '');
    email.value = p_email != null ? p_email : '';
  }
  setContact(String? p_contact) async{
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString('contact', p_contact != null ? p_contact : '');
    contact.value = p_contact != null ? p_contact : '';
  }
  setUser(User puser){
    user.value = puser;
  }
  setCloudMessagingToken(String? token)async{
    cloud_messaging_token = token.toString();
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString('cloud_messaging_token', cloud_messaging_token);
    storage.commit();
  }
  verifyAccount(){

  }
  getUsers() async {
    try{
      await loadAuthInfo();
      var response = await AuthService.getUsers();
      if(response is Success){
        // print('Success');
        usersList.clear();
        setUsersList(response.response as List<User>);
      }
      if(response is Failure){
        print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      print("Exception  "+ex.toString());
    }
  }
  getUserInfo() async {
    try{
      var response = await AuthService.getUser(getUserId);
      if(response is Success){
        setUser(response.response as User);

        setUserId(user.value.id);
        setPseudo(user.value.pseudo);
        setContact(user.value.contact);
        setCode(user.value.code);
        setis_actif(user.value.is_actif);
      }
      if(response is Failure){
        // print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      // print("Exception  "+ex.toString());
    }
  }
  register(Map data) async{
    if(isChecked.value == false){
      showAlerte('Information importante', "Veuillez lire et accepter la politique de confidentialité et les conditions d'utilisations.");
      return;
    }
    isProcessing(true);
    try{
      var _pseudoExist = await checkPseudo();
      var _is_actif = await checkis_actif(txtPseudoController.text);
      if(_pseudoExist == true){
        isProcessing(false);
         showAlerte('Alerte', 'Désolé ce pseudo existe déjà');
         return;
      }
      if(_is_actif == false){
        isProcessing(false);
        showAlerte('Compte désactivé', "Désolé votre compte est temporairement désactivé.");
        return;
      }
      var response = await AuthService.register(data);
      if(response is Success){
        isProcessing(false);
        setUser(response.response as User);
        setPseudo(user.value.pseudo);
        setUserId(user.value.id);
        setContact(user.value.contact);
        setCode(user.value.code);
        setis_actif(user.value.is_actif);
        if(user.value.account_exist == 1){
          iniAuthInfo();
          Get.offNamed(AppRoutes.HOME);
        } else {
          setStep(2);
        }
      }
      if(response is Failure){
        isProcessing(false);
        showSnackBar("Echec d'authentification", response.errorResponse.toString(), Colors.red);
        // print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      isProcessing(false);
      // print("Exception  "+ex.toString());
      showSnackBar("Echec d'authentification", ex.toString(), Colors.red);
    }
  }
  confirm(Map data) async{
    // showAlerte('Information', 'Confirmation');
    isProcessing(true);
    try{
      var response = await AuthService.confirm(data);
      if(response is Success){
        isProcessing(false);
        setUser(response.response as User);

        setUserId(user.value.id);
        setContact(user.value.contact);
        setCode(user.value.code);
        setis_actif(user.value.is_actif);
        setPseudo(user.value.pseudo);
        setToken(user.value.token);

        iniAuthInfo();
        Get.offNamed(AppRoutes.HOME);
      }
      if(response is Failure){
        isProcessing(false);
        // print("Erreur "+response.errorResponse.toString());
        showSnackBar("Echec de confirmation", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      isProcessing(false);
      // print("Exception  "+ex.toString());
      showSnackBar("Echec d'authentification", ex.toString(), Colors.red);
    }
  }

  // FIREBASE CLOUD MESSAGING CONFIGURATION
  late FirebaseMessaging messaging;

  initCloudMessaging() async{
    messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // print('User granted permission: ${settings.authorizationStatus}');

    messaging.getToken().then((value) async{
      await setCloudMessagingToken(value.toString());
      // print('Cloud Messaging Token: '+value.toString());
    });
  }


  @override
  void onInit() {
    super.onInit();
    initCloudMessaging();
    getUsers();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {

  }

  String? validContact(value){
    if (value == null || value.isEmpty) return 'Numéro de téléphone obligatoire svp';
    if (value.length != 10) return 'Numéro de téléphone doit etre de 10 chiffre svp';
    return null;
  }
  String? validPseudo(value){
    if (value == null || value.isEmpty) return 'Entrer un nom utilisateur svp';
    if (value.length == 1) return 'Nom utilisateur trop court';
    return null;
  }
  void checkForm(){
    final isValid = formkey.currentState!.validate();
    if(isValid){
      return ;
    }
    formkey.currentState!.save();
  }
}
