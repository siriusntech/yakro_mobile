import 'package:get/get.dart';

import '../modules/actualite/bindings/actualite_binding.dart';
import '../modules/actualite/views/actualite_show_view.dart';
import '../modules/actualite/views/actualite_view.dart';
import '../modules/agenda/bindings/agenda_binding.dart';
import '../modules/agenda/views/agenda_show_view.dart';
import '../modules/agenda/views/agenda_view.dart';
import '../modules/alerte/bindings/alerte_binding.dart';
import '../modules/alerte/views/alerte_add_view.dart';
import '../modules/alerte/views/alerte_all_view.dart';
import '../modules/alerte/views/alerte_edit_view.dart';
import '../modules/alerte/views/alerte_mine_view.dart';
import '../modules/alerte/views/alerte_show_view.dart';
import '../modules/alerte/views/alerte_view.dart';
import '../modules/annuaire/bindings/annuaire_binding.dart';
import '../modules/annuaire/views/annuaire_view.dart';
import '../modules/apropos/bindings/apropos_binding.dart';
import '../modules/apropos/views/apropos_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/auth/views/condition_view.dart';
import '../modules/barsMaquis/bindings/bars_maquis_binding.dart';
import '../modules/barsMaquis/views/bars_maquis_view.dart';
import '../modules/cocan/bindings/cocan_binding.dart';
import '../modules/cocan/views/cocan_view.dart';
import '../modules/commerce/bindings/commerce_binding.dart';
import '../modules/commerce/views/commerce_show_view.dart';
import '../modules/commerce/views/commerce_view.dart';
import '../modules/debut/bindings/debut_binding.dart';
import '../modules/debut/views/debut_view.dart';
import '../modules/diffusion/bindings/diffusion_binding.dart';
import '../modules/diffusion/views/diffusion_show_view.dart';
import '../modules/diffusion/views/diffusion_view.dart';
import '../modules/discussion/bindings/discussion_binding.dart';
import '../modules/discussion/views/discussion_show.dart';
import '../modules/discussion/views/discussion_view.dart';
import '../modules/historique/bindings/historique_binding.dart';
import '../modules/historique/views/historique_show.dart';
import '../modules/historique/views/historique_view.dart';
import '../modules/historique/views/information_show.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/hotel/bindings/hotel_binding.dart';
import '../modules/hotel/views/hotel_view.dart';
import '../modules/job/bindings/job_binding.dart';
import '../modules/job/views/job_show_view.dart';
import '../modules/job/views/job_view.dart';
import '../modules/message/bindings/message_binding.dart';
import '../modules/message/views/message_add_view.dart';
import '../modules/message/views/message_all_view.dart';
import '../modules/message/views/message_edit_view.dart';
import '../modules/message/views/message_mine_view.dart';
import '../modules/message/views/message_show_view.dart';
import '../modules/message/views/message_view.dart';
import '../modules/nouscontactez/bindings/nouscontactez_binding.dart';
import '../modules/nouscontactez/views/nouscontactez_view.dart';
import '../modules/pharmacie/bindings/pharmacie_binding.dart';
import '../modules/pharmacie/views/pharmacie_show_view.dart';
import '../modules/pharmacie/views/pharmacie_view.dart';
import '../modules/restaurant/bindings/restaurant_binding.dart';
import '../modules/restaurant/views/restaurant_view.dart';
import '../modules/sitetouristiques/bindings/sitetouristiques_binding.dart';
import '../modules/sitetouristiques/views/sitetouristiques_view.dart';
import '../modules/slider/bindings/slider_binding.dart';
import '../modules/slider/views/slider_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/trajet/bindings/trajet_binding.dart';
import '../modules/trajet/views/trajet_view.dart';
import '../modules/widget_splashScreen/bindings/widget_splash_screen_binding.dart';
import '../modules/widget_splashScreen/views/widget_splash_screen_view.dart';
import '../modules/zoom/bindings/zoom_binding.dart';
import '../modules/zoom/views/zoom_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.SPLASH;
  static const INITIAL = Routes.WIDGET_SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGE,
      page: () => MessageView(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: _Paths.CONDITION,
      page: () => ConditionView(),
    ),
    GetPage(
      name: _Paths.ALERTE,
      page: () => AlerteView(),
      binding: AlerteBinding(),
    ),
    GetPage(
      name: _Paths.ACTUALITE,
      page: () => ActualiteView(),
      binding: ActualiteBinding(),
    ),
    GetPage(
      name: _Paths.AGENDA,
      page: () => AgendaView(),
      binding: AgendaBinding(),
    ),
    GetPage(
      name: _Paths.COMMERCE,
      page: () => CommerceView(),
      binding: CommerceBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_COMMERCE,
      page: () => CommerceShowView(),
      binding: CommerceBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_AGENDA,
      page: () => AgendaShowView(),
      binding: AgendaBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_ALERTE,
      page: () => AlerteShowView(),
      binding: AlerteBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_MESSAGE,
      page: () => MessageShowView(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_DIFFUSION,
      page: () => DiffusionShowView(),
      binding: DiffusionBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_ACTUALITE,
      page: () => ActualiteShowView(),
      binding: ActualiteBinding(),
    ),
    GetPage(
      name: _Paths.DIFFUSION,
      page: () => DiffusionView(),
      binding: DiffusionBinding(),
    ),
    GetPage(
      name: _Paths.APROPOS,
      page: () => AproposView(),
      binding: AproposBinding(),
    ),
    GetPage(
      name: _Paths.NOUSCONTACTEZ,
      page: () => NouscontactezView(),
      binding: NouscontactezBinding(),
    ),
    GetPage(
      name: _Paths.MES_ALERTES,
      page: () => AlerteMineView(),
      binding: AlerteBinding(),
    ),
    GetPage(
      name: _Paths.ALL_ALERTES,
      page: () => AlerteAllView(),
      binding: AlerteBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ALERTE,
      page: () => AlerteAddView(),
      binding: AlerteBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_ALERTE,
      page: () => AlerteEditView(),
      binding: AlerteBinding(),
    ),
    GetPage(
      name: _Paths.MES_MESSAGES,
      page: () => MessageMineView(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: _Paths.ALL_MESSAGES,
      page: () => MessageAllView(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: _Paths.ADD_MESSAGE,
      page: () => MessageAddView(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_MESSAGE,
      page: () => MessageEditView(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.DISCUSSION,
      page: () => DiscussionView(),
      binding: DiscussionBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_DISCUSSION,
      page: () => DiscussionShow(),
      binding: DiscussionBinding(),
    ),
    GetPage(
      name: _Paths.HISTORIQUE,
      page: () => HistoriqueView(),
      binding: HistoriqueBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_HISTORIQUE,
      page: () => HistoriqueShow(),
      binding: HistoriqueBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_INFORMATION,
      page: () => InformationShow(),
      binding: HistoriqueBinding(),
    ),
    GetPage(
      name: _Paths.PHARMACIE,
      page: () => PharmacieView(),
      binding: PharmacieBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_PHARMACIE,
      page: () => PharmacieShowView(),
      binding: PharmacieBinding(),
    ),
    GetPage(
      name: _Paths.ANNUAIRE,
      page: () => AnnuaireView(),
      binding: AnnuaireBinding(),
    ),
    GetPage(
      name: _Paths.DEBUT,
      page: () => DebutView(),
      binding: DebutBinding(),
    ),
    GetPage(
      name: _Paths.ZOOM,
      page: () => ZoomView(),
      binding: ZoomBinding(),
    ),
    GetPage(
      name: _Paths.JOB,
      page: () => JobView(),
      binding: JobBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_JOB,
      page: () => JobShowView(),
      binding: JobBinding(),
    ),
    GetPage(
      name: _Paths.COCAN,
      page: () => CocanView(),
      binding: CocanBinding(),
    ),
    GetPage(
      name: _Paths.TRAJET,
      page: () => TrajetView(),
      binding: TrajetBinding(),
    ),
    //roland kekre
    GetPage(
      name: _Paths.HOTEL,
      page: () => const HotelView(),
      binding: HotelBinding(),
    ),
    GetPage(
      name: _Paths.RESTAURANT,
      page: () => const RestaurantView(),
      binding: RestaurantBinding(),
    ),
    GetPage(
      name: _Paths.BARS_MAQUIS,
      page: () => const BarsMaquisView(),
      binding: BarsMaquisBinding(),
      children: [
        GetPage(
          name: _Paths.BARS_MAQUIS,
          page: () => const BarsMaquisView(),
          binding: BarsMaquisBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.WIDGET_SPLASH_SCREEN,
      page: () => WidgetSplashScreenView(),
      binding: WidgetSplashScreenBinding(),
      children: [
        GetPage(
          name: _Paths.WIDGET_SPLASH_SCREEN,
          page: () => WidgetSplashScreenView(),
          binding: WidgetSplashScreenBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.SITETOURISTIQUES,
      page: () => const SitetouristiquesView(),
      binding: SitetouristiquesBinding(),
    ),
    GetPage(
      name: _Paths.SLIDER,
      page: () => const SliderView(),
      binding: SliderBinding(),
    ),
  ];
}
