import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/controllers/path_controller.dart';
import 'package:jaime_yakro/Screens/Modules/Conciergerie/Course/path_course.dart';

class AddLocationComponent extends StatefulWidget {
  const AddLocationComponent({super.key});

  @override
  State<AddLocationComponent> createState() => _AddLocationComponentState();
}

class _AddLocationComponentState extends State<AddLocationComponent> {
  final controller = Get.find<CourseConciergerieScreenController>();
  final controllerUserConcierge = Get.put(UserConciergeController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Ajoutez un compte',
            style: TextStyle(fontSize: 19),
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
      content: Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: TextFormField(
                    controller:
                        controllerUserConcierge.nomPrenomController.value,
                    decoration: InputDecoration(
                        // hintText: "Location",
                        labelText: "Nom & Prenom *",
                        labelStyle:
                            TextStyle(color: controller.colorPrimary.value),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: controller.colorPrimary.value,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: controller.colorPrimary.value),
                            borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: controller.colorPrimary.value, width: 2),
                            borderRadius: BorderRadius.circular(10)))),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: TextFormField(
                    controller:
                        controllerUserConcierge.telephoneController.value,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: InputDecoration(
                        // hintText: "Location",
                        labelText: "Telephone *",

                        labelStyle:
                            TextStyle(color: controller.colorPrimary.value),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: controller.colorPrimary.value,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: controller.colorPrimary.value),
                            borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: controller.colorPrimary.value, width: 2),
                            borderRadius: BorderRadius.circular(10)))),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: TextFormField(
                    controller: controllerUserConcierge.emailController.value,
                    decoration: InputDecoration(
                        // hintText: "Location",
                        labelText: "Email",
                        labelStyle:
                            TextStyle(color: controller.colorPrimary.value),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: controller.colorPrimary.value,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: controller.colorPrimary.value),
                            borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: controller.colorPrimary.value, width: 2),
                            borderRadius: BorderRadius.circular(10)))),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: TextFormField(
                    controller:
                        controllerUserConcierge.locationController.value,
                    decoration: InputDecoration(
                        // hintText: "Location",
                        labelText: "Adresse *",
                        labelStyle:
                            TextStyle(color: controller.colorPrimary.value),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: controller.colorPrimary.value,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: controller.colorPrimary.value),
                            borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: controller.colorPrimary.value, width: 2),
                            borderRadius: BorderRadius.circular(10)))),
              ),
              const SizedBox(
                height: 30,
              ),
              Obx(() => controllerUserConcierge.userConciergeLoading.value
                  ? Center(
                      child: SpinKitDoubleBounce(
                        color: controller.colorPrimary.value,
                        size: 50,
                        duration: const Duration(seconds: 1),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        controllerUserConcierge.createUserConcierge(context);
                      },
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: controller.colorPrimary.value,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Ajouter',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
