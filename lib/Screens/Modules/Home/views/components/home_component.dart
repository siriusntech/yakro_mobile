import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
// import 'package:jaime_yakro/Providers/services/notification_service.dart';
import 'package:jaime_yakro/Providers/services/notifications_service.dart';
import 'package:jaime_yakro/Screens/Modules/Home/path_home.dart';

import '../../../../../Providers/path_providers.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({super.key});

  @override
  State<HomeComponent> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  NotificationServices notificationServices = NotificationServices();

  final moduleController = Get.put(ModuleController());
  @override
  void initState() {
    super.initState();
    notificationServices.init(context);
    moduleController.getModules();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
                color: ConstColors.vertColorFonce.withOpacity(0.5),
                borderRadius: BorderRadius.circular(150)),
          ),
        ),
        Positioned(
          top: 50,
          right: 50,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                color: Color(0xFF1a4205),
                borderRadius: BorderRadius.circular(100)),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                color: ConstColors.vertColorFonce.withOpacity(0.5),
                borderRadius: BorderRadius.circular(100)),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: const Color(0xFF1a4205).withOpacity(0.5),
                borderRadius: BorderRadius.circular(50)),
          ),
        ),
        const CardGroudElement()
      ],
    );
  }
}
