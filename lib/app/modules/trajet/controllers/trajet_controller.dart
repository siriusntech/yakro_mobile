import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/reservation_model.dart';
import '../../../models/trajet_model.dart';

class TrajetController extends GetxController with GetSingleTickerProviderStateMixin {

  var trajetList = List<TrajetModel>.empty(growable: true).obs;
  var mesTrajetList = List<TrajetModel>.empty(growable: true).obs;
  var mesReservationList = List<ReservationModel>.empty(growable: true).obs;

  var selectedTrajet = TrajetModel().obs;
  var selectedReservation = ReservationModel().obs;

  var user_id = 0.obs;

  final List<Tab> myTabs = const <Tab>[
    Tab(
        text: 'Trajets'
    ),
    Tab(
        text: 'Mes trajets'
    ),
    Tab(
        text: 'Mes reservations'
    ),
  ];

  late TabController tabsController;


  void iniTrajets(){
    Iterable<TrajetModel> trajets = [
      new TrajetModel(
        id: 1,
        depart: 'Cocody',
        destination: 'Yopougon',
        date_depart: '10-05-2023',
        heure_depart: '10:30',
        nombre_place: 4,
        place_reserver: 1,
        point_rassemblement: 'Cocody',
        prix_place: 700,
        statut: 0,
        date: '08-04-2023',
        is_reserved: 0,
      ),
      new TrajetModel(
        id: 2,
        depart: 'Ab',
        destination: 'Adj',
        date_depart: '10-05-2023',
        heure_depart: '10:30',
        nombre_place: 4,
        place_reserver: 1,
        point_rassemblement: 'Cocody',
        prix_place: 400,
        statut: 1,
        date: '06-04-2023',
        is_reserved: 1,
      ),
      new TrajetModel(
        id: 3,
        depart: 'Man',
        destination: 'Koum',
        date_depart: '10-05-2023',
        heure_depart: '10:30',
        nombre_place: 4,
        place_reserver: 1,
        point_rassemblement: 'Cocody',
        prix_place: 500,
        statut: 0,
        date: '10-04-2023',
        is_reserved: 0,
      ),
    ];

    trajetList.addAll(trajets);
  }

  int setPlaceDisponible(TrajetModel trajet){
    return trajet.nombre_place! - trajet.place_reserver!;
  }

  @override
  void onInit() {
    super.onInit();

    tabsController = TabController(vsync: this, length: myTabs.length);

    iniTrajets();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
