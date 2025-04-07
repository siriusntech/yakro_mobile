import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Helpers/helpers.dart';
import 'package:jaime_yakro/Providers/controllers/path_controller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  //vool var
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final controller = Get.put(NotificationController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstColors.vertColorFonce,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Notification',
          style: TextStyle(
            color: ConstColors.appbarTextColor,
            fontWeight: FontWeight.w300,),)
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(
                  'assets/images/notify.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Text(
                '${Get.arguments['title']}',
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Nunito-Regular',
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    "${Get.arguments['body']}",
                    style: const TextStyle(
                        fontFamily: 'Nunito-Light',
                        color: Colors.black,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Get.arguments['type'] == '/mise_a_jour'
                  ? InkWell(
                      onTap: () {
                        if (Platform.isAndroid) {
                          Helpers.launchInAppBrowsers(
                              Uri.parse('${Get.arguments['link_app_ios']}'));
                        } else if (Platform.isIOS) {
                          Helpers.launchInAppBrowser(Uri.parse(
                              '${Get.arguments['link_app_android']}'));
                        }
                      },
                      child: Container(
                        height: 50,
                        width: width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppConfig.cardRadius),
                            color: ConstColors.vertColorFonce,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: Offset(0, 5))
                            ]),
                        child: const Text(
                          "Voir sur l'application",
                          style: TextStyle(
                            color: ConstColors.appbarTextColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 50,
                        width: width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppConfig.cardRadius),
                            color: ConstColors.vertColorFonce,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: Offset(0, 5))
                            ]),
                        child: const Text(
                          'Retour',
                          style: TextStyle(
                            color: ConstColors.appbarTextColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
