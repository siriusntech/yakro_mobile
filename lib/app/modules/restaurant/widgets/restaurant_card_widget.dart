import 'package:flutter/material.dart';
import 'package:jaime_yakro/app/Utils/app_icons.dart';
import 'package:jaime_yakro/app/models/restaurant_model.dart';
import 'package:jaime_yakro/app/modules/restaurant/controllers/restaurant_controller.dart';
import 'package:jaime_yakro/app/widgets/image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/default_image.dart';
import '../../../widgets/text_widget.dart';

import 'package:get/get.dart';

class RestaurantCardWidget extends StatelessWidget {
  final Restaurant commerce;
  final VoidCallback? action;

  RestaurantCardWidget({required this.commerce, this.action});

  final RestaurantController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: InkWell(
        onTap: action,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: Card(
            elevation: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child: TextWidget(
                      text: commerce.type.toString().toUpperCase(),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.red,
                      maxLine: 50,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        ICON_STORE,
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        child: TextWidget(
                          text: commerce.nom!.toUpperCase(),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          maxLine: 50,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Visibility(
                      visible: commerce.site != null && commerce.site != '',
                      child: InkWell(
                        onTap: () {
                          launchUrl(Uri.parse(commerce.site.toString()));
                        },
                        child: Row(
                          children: [
                            TextWidget(
                                text: 'Site Internet: ',
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                            SizedBox(
                              width: 3,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: TextWidget(
                                text: commerce.site.toString(),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                maxLine: 50,
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 3.0,
                  ),
                  Visibility(
                      visible: commerce.email != null && commerce.email != '',
                      child: InkWell(
                        onTap: () {
                          launchUrl(Uri.parse(commerce.email.toString()));
                        },
                        child: Wrap(
                          children: [
                            Image.asset(
                              AppIcons.EMAIL,
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: TextWidget(
                                text: commerce.email.toString(),
                                fontWeight: FontWeight.w600,
                                fontSize: 15.5,
                                maxLine: 50,
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Visibility(
                      visible:
                          commerce.facebook != null && commerce.facebook != '',
                      child: InkWell(
                        onTap: () {
                          launchUrl(Uri.parse(commerce.facebook.toString()));
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              AppIcons.FACEBOOK,
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: TextWidget(
                                text: commerce.facebook.toString(),
                                fontWeight: FontWeight.w600,
                                fontSize: 15.5,
                                maxLine: 50,
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 5.0,
                  ),
                  Visibility(
                      visible:
                          commerce.linkedln != null && commerce.linkedln != '',
                      child: InkWell(
                        onTap: () {
                          launchUrl(Uri.parse(commerce.linkedln.toString()));
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              AppIcons.LINKEDIN,
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: TextWidget(
                                text: commerce.linkedln.toString(),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                maxLine: 50,
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        ICON_NAME,
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        child: TextWidget(
                          text: commerce.responsable.toString().toUpperCase(),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          maxLine: 50,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      controller.showAlerte(commerce.contact.toString());
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          ICON_TELEPHONE,
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        TextWidget(
                          text: commerce.contact.toString(),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                    text: commerce.description!,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    maxLine: 4,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    height: 230,
                    child: ImageWidget(
                      isNetWork: true,
                      url: commerce.medias?.isNotEmpty == true
                          ? commerce.medias![0].url
                          : '',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      default_image: DefaultImage.COMMERCE,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Divider(),
                  SizedBox(
                    height: 4,
                  ),
                  InkWell(
                    onTap: () {
                      // MapsLauncher.launchCoordinates(double.parse(commerce.longitude!), double.parse(commerce.latitude!), commerce.nom);
                      launch(commerce.lien.toString());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.map,
                              color: Colors.red,
                            ),
                            SizedBox(
                                width:
                                    5.0), // Ajouté un espace entre l'icône et le texte
                            TextWidget(
                              text: "Itinéraire",
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        SizedBox(
                            width:
                                30.0), // Ajouté un espace entre le texte "Itinéraire" et la note
                        Visibility(
                          visible: commerce.moyenneRestaurant != null,
                          child: Row(
                            children: [
                              TextWidget(
                                text: '${commerce.moyenneRestaurant}',
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                alignement: TextAlign.left,
                              ),
                              Icon(Icons.star_half_sharp,
                                  color: Colors.amber[800], size: 25),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
