import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Conciergerie/Course/path_course.dart';

class ListeLocationComponent extends StatefulWidget {
  const ListeLocationComponent({super.key});

  @override
  State<ListeLocationComponent> createState() => _ListeLocationComponentState();
}

class _ListeLocationComponentState extends State<ListeLocationComponent> {
  final controllerUserConcierge = Get.put(UserConciergeController());
  final controller = Get.find<CourseConciergerieScreenController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "Liste des Comptes",
            style: TextStyle(fontSize: 20),
          ),
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.close,
                color: controller.colorPrimary.value,
              ))
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Annuler',
              style: TextStyle(color: controller.colorPrimary.value),
            )),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('valider',
              style: TextStyle(color: ConstColors.alertSuccess)),
        ),
      ],
      content: Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(),
          child: Obx(
            () => controllerUserConcierge.userConciergeLoading.value
                ? Center(
                    child: SpinKitDoubleBounce(
                    color: controller.colorPrimary.value,
                  ))
                : controllerUserConcierge.userConciergeList.isNotEmpty
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                                itemBuilder: (context, index) =>
                                    RadioListTile<UserBoutiqueModel>(
                                      title: Text(
                                        "${controllerUserConcierge.userConciergeList[index].nom} ${controllerUserConcierge.userConciergeList[index].prenoms}",
                                      ),
                                      subtitle: Text(
                                          "${controllerUserConcierge.userConciergeList[index].quartier}"),
                                      value: controllerUserConcierge
                                          .userConciergeList[index],
                                      groupValue:
                                          controller.userConcierge.value,
                                      onChanged: (value) {
                                        setState(() {
                                          controller.userConcierge.value =
                                              value;
                                        });
                                        controller.changeUserConcierge(value!);

                                        // print(controller.userConcierge.value!.nom);
                                      },
                                      activeColor:
                                          controller.colorPrimary.value,
                                    ),
                                separatorBuilder: (_, index) => const Divider(),
                                itemCount: controllerUserConcierge
                                    .userConciergeList.length),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                              showDialog(
                                  context: context,
                                  builder: (_) => const AddLocationComponent());
                            },
                            child: Text(
                              'Ajouter un Compte',
                              style: TextStyle(
                                  color: controller.colorPrimary.value),
                            ),
                          )
                        ],
                      )
                    : Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Aucun Compte n'est disponible"),
                          const SizedBox(
                            height: 10,
                          ),
                          IconButton(
                              onPressed: () {
                                controllerUserConcierge
                                    .getUserConciergeWithDeviceId();
                              },
                              icon: const Icon(Icons.refresh,
                                  color: Color(0xff6CA0B6))),
                          TextButton(
                            onPressed: () {
                              Get.back();
                              showDialog(
                                  context: context,
                                  builder: (_) => const AddLocationComponent());
                            },
                            child: Text(
                              'Ajouter un Compte',
                              style: TextStyle(
                                  color: controller.colorPrimary.value),
                            ),
                          )
                        ],
                      )),
          )),
    );
  }
}
