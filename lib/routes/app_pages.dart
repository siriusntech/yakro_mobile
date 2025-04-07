import 'package:jaime_yakro/Screens/Modules/Actualite/path_actualite.dart';
import 'package:jaime_yakro/Screens/Modules/Alerte/path_alerte.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';
import 'package:jaime_yakro/Screens/Modules/Conciergerie/Course/path_course.dart';
import 'package:jaime_yakro/Screens/Modules/Conciergerie/Coursier/path_coursier.dart';
import 'package:jaime_yakro/Screens/Modules/Debut/path_debut.dart';
import 'package:jaime_yakro/Screens/Modules/Evenement/path_evenement.dart';
import 'package:jaime_yakro/Screens/Modules/Home/path_home.dart';
import 'package:jaime_yakro/Screens/Modules/Notification/views/notification_course_conciergerie.dart';
import 'package:jaime_yakro/Screens/Modules/Pharmacie/path_pharmacie.dart';
import 'package:jaime_yakro/Screens/Modules/SiteTourisme/path_tourisme.dart';
import 'package:jaime_yakro/Screens/Modules/Splash/path_splash.dart';
import 'package:jaime_yakro/Screens/Modules/Commerce/path_commerce.dart';
import 'package:get/get.dart';

import '../Screens/Modules/Conciergerie/Coursier/auth/path_auth_coursier.dart';
import '../Screens/Modules/Hotel/path_hotel.dart';
import '../Screens/Modules/Notification/path_notification.dart';
import '../Screens/Modules/Reduction/reduction_path.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.SPLASH;
  static const initial = AppRoutes.widgetSplashScreen;

  static final routes = [
    GetPage(
      name: AppRoutes.widgetSplashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: _Paths.debutScreen,
      page: () => DebutScreen(),
      binding: DebutScreenBinding(),
    ),
    GetPage(
        name: _Paths.homeScreen,
        page: () => const HomeScreen(),
        binding: HomeScreenBinding()),

    //Hotel
    GetPage(
      name: _Paths.hotelScreen,
      page: () => const HotelScreen(),
      binding: HotelScreenBinding(),
    ),
    GetPage(
      name: _Paths.hotelSingleScreen,
      page: () => const HotelSingleScreen(),
      binding: HotelScreenBinding(),
    ),

    //Commerce
    GetPage(
        name: _Paths.commerceScreen,
        page: () => const CommerceScreen(),
        binding: CommerceScreenBinding()),
    GetPage(
        name: _Paths.commerceSingleScreen,
        page: () => const CommerceSingleScreen(),
        binding: CommerceSingleScreenBinding()),

    //Evenement
    GetPage(
        name: _Paths.evenementScreen,
        page: () => const EvenementScreen(),
        binding: EvenementScreenBinding()),
    GetPage(
        name: _Paths.evenementSingleScreen,
        page: () => const EvenementSingleScreen(),
        binding: EvenementSingleScreenBinding()),

    //Boutique
    GetPage(
      name: _Paths.commerceScreen,
      page: () => const BoutiqueScreen(),
      binding: BoutiqueScreenBinding(),
    ),

    //Alerte
    GetPage(
      name: _Paths.alerteScreen,
      page: () => const AlerteScreen(),
      binding: AlerteScreenBinding(),
    ),
    GetPage(
      name: _Paths.alerteSingleScreen,
      page: () => const AlerteSingleScreen(),
      binding: AlerteSingleScreenBinding(),
    ),
    GetPage(
      name: _Paths.alerteAddScreen,
      page: () => const AddAlertScreen(),
      binding: AlerteAddScreenBinding(),
    ),

    //Actualités
    GetPage(
      name: _Paths.actualiteScreen,
      page: () => const ActualiteScreen(),
      binding: ActualiteScreenBinding(),
    ),
    GetPage(
      name: _Paths.actualiteSingleScreen,
      page: () => const ActualiteSingleScreen(),
      binding: ActualiteSingleScreenBinding(),
    ),

    //Pharmacie
    GetPage(
        name: _Paths.pharmacieScreen,
        page: () => const PharmacieScreen(),
        binding: PharmacieScreenBinding()),

    //Site Touristique
    GetPage(
        name: _Paths.siteTouristiqueScreen,
        page: () => const SiteTourismeScreen(),
        binding: SiteTourismeScreenBinding()),

    //Notification Screen
    GetPage(
        name: _Paths.notificationScreen,
        page: () => const NotificationScreen(),
        binding: NotificationScreenBinding()),

    //Auth Coursier
    ///Register Coursier
    GetPage(
        name: _Paths.registerCoursierScreen,
        page: () => const RegisterCoursierScreen(),
        binding: RegisterCoursierBinding()),

    ///Login Coursier
    GetPage(
        name: _Paths.loginCoursierScreen,
        page: () => const LoginCoursierScreen(),
        binding: LoginCoursierBinding()),

    ///Profile
    GetPage(
        name: _Paths.profileCoursierScreen,
        page: () => const ProfilCoursierScreen(),
        binding: ProfilCoursierBinding(),
        transition: Transition.rightToLeft),

    //Home Coursier
    GetPage(
        name: _Paths.homeCoursierScreen,
        page: () => const HomeCoursierScreen(),
        binding: HomeCoursierScreenBinding()),

    //Course Conciergerie
    GetPage(
        name: _Paths.courseConciergerieScreen,
        page: () => const CourseConciergerieScreen(),
        binding: CourseConciergerieScreenBinding()),

    GetPage(
        name: _Paths.notificationCourseConciergerie,
        page: () => const NotificationCourseConciergerie(),
        binding: CourseConciergerieScreenBinding()),


    //Reduction
    GetPage(
        name: _Paths.reductionScreen,
        page: () => const ReductionScreen(),
        binding: ReductionScreenBinding()),

    //Reservation
    GetPage(
        name: _Paths.reservationScreen,
        page: () => const ReservationScreen(),
        binding: ReservationScreenBinding()),

    //Scanner
    GetPage(
        name: _Paths.scannerScreen,
        page: () => const ScannerScreen(),
        binding: ScannerScreenBinding()),

    //Choix Type Chambre Hotek
    //Reservation
    GetPage(
        name: _Paths.typeChambreHotelScreen,
        page: () => const TypeChambreHotelScreen(),
        binding: TypeChambreHotelScreenBinding()),
  ];
}
