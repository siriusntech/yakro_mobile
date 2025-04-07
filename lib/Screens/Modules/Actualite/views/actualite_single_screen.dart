import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Screens/Modules/Actualite/path_actualite.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ActualiteSingleScreen extends GetView<ActualiteSingleScreenController> {
  const ActualiteSingleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomSheet: Container(
          height: height / 10,
          width: width,
          padding: const EdgeInsets.all(
            AppConfig.paddingBodySimple,
          ),
          decoration: BoxDecoration(color: controller.colorPrimary.value),
          child: TextFormField(
            controller: controller.commentController.value,
            style: TextStyle(color: controller.colorPrimary.value),
            minLines: 1,
            maxLines: 3,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: controller.colorPrimary.value)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: controller.colorPrimary.value)),
                suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send,
                      color: Color(0xFFF9A413),
                    )),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
        body: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: height / 3.3,
                    width: width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/resto_4.jpg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(AppConfig.cardRadius),
                          bottomRight: Radius.circular(AppConfig.cardRadius),
                        )),
                  ),
                  Positioned(
                    top: 40,
                    left: 10,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppConfig.cardRadius),
                          color:
                              controller.colorPrimary.value.withOpacity(0.8)),
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.chevron_left)),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
                height: height / 13,
                width: width,
                // decoration: BoxDecoration(color: Colors.orangeAccent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: controller.colorPrimary.value,
                          borderRadius:
                              BorderRadius.circular(AppConfig.cardRadius)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.thumb_down,
                                color: Colors.white,
                              )),
                          Text(
                            '5',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: GoogleFonts.nunito().fontFamily,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: controller.colorPrimary.value,
                          borderRadius:
                              BorderRadius.circular(AppConfig.cardRadius)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.thumb_up,
                                color: Color(0xFFF9A413),
                              )),
                          Text(
                            '5',
                            style: TextStyle(
                                color: const Color(0xFFF9A413),
                                fontFamily: GoogleFonts.nunito().fontFamily,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Commentaire(s)',
                      style: TextStyle(
                          fontSize: 23,
                          fontFamily: GoogleFonts.nunito().fontFamily),
                    ),
                    Expanded(
                      child: Container(
                        // color: Colors.amber,
                        padding:
                            const EdgeInsets.all(AppConfig.paddingBodySimple),
                        child: ListView.separated(
                            itemBuilder: (conttext, index) => Container(
                                  padding: const EdgeInsets.all(5),
                                  height: height / 11,
                                  width: width,
                                  decoration: BoxDecoration(
                                      color: controller.colorPrimary.value
                                          .withOpacity(0.01),
                                      borderRadius: BorderRadius.circular(
                                          AppConfig.borderRadius)),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            controller.colorPrimary.value,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: RichText(
                                            text: TextSpan(
                                                text:
                                                    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Culpa ut labore tenetur expedita. Possimus totam laudantium, omnis velit iusto quam impedit provident vitae aut deleniti? Repellendus aut asperiores nisi sed.",
                                                style: GoogleFonts.nunito(
                                                    textStyle: const TextStyle(
                                                        color: Colors.black)))),
                                      )
                                    ],
                                  ),
                                ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 20,
                                ),
                            itemCount: 20),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
