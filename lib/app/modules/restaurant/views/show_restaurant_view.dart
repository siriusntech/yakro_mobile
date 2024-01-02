import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Utils/app_constantes.dart';
import '../../../Utils/app_icons.dart';
import '../../../controllers/main_controller.dart';
import '../../../models/CommentaireNote.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../home/views/home_view.dart';
import '../../zoom/controllers/zoom_controller.dart';
import '../controllers/restaurant_controller.dart';


class ShowRestaurantView extends GetView<RestaurantController>{


 const ShowRestaurantView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
     final ZoomController zoomCtrl = Get.put(ZoomController());
     final MainController settingsCtrl = Get.find();
     final AuthController authentification = Get.put(AuthController());

     final listMedia = controller.selectedCommerce.value.medias!.map((element) {
       return element.url;
     }).toList();

      //  final Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
        // final data = arguments['data'] as Restaurant;
    //     List listMedia =  data.medias!.map((element) {
    //  return element.url;
    // }).toList();

    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.vert_color_fonce,
        title:TextWidget(text: 'Restaurants et autres',fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
        ),
        actions: [
          IconButton(
              onPressed: () async{
                await controller.refreshData();
              },
              icon: Icon(Icons.refresh, color: Colors.white, size: 30,)
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: TextWidget(text: controller.selectedCommerce.value.type.toString().toUpperCase(), fontWeight: FontWeight.w600,
                  fontSize: 14,maxLine: 50,
                ),
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Image.asset(ICON_STORE, width: 20, height: 20,),
                  SizedBox(width: 4.0),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child: TextWidget(text: controller.selectedCommerce.value.nom.toString().toUpperCase(), fontWeight: FontWeight.w600, color: Colors.red,
                      fontSize: 17,maxLine: 50,
                    ),
                  )
                ],
              ),
              SizedBox(height: 3.0,),
              Visibility(
                  visible: controller.selectedCommerce.value.site != null && controller.selectedCommerce.value.site != '',
                  child: InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(controller.selectedCommerce.value.site.toString()));
                    },
                    child: Row(
                      children: [
                        TextWidget(text: 'Site Internet: ', fontWeight: FontWeight.w600, fontSize: 14),
                        SizedBox(width: 3,),
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: TextWidget(text: controller.selectedCommerce.value.site.toString(), fontWeight: FontWeight.w600,
                            fontSize: 15,maxLine: 50,
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 3.0,),
              Visibility(
                  visible: controller.selectedCommerce.value.email != null && controller.selectedCommerce.value.email != '',
                  child: InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(controller.selectedCommerce.value.email.toString()));
                    },
                    child: Row(
                      children: [
                         Image.asset(AppIcons.EMAIL, width: 20, height: 20,),
                        SizedBox(width: 3,),
                        SizedBox(width: 3,),
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: TextWidget(text: controller.selectedCommerce.value.email.toString(), fontWeight: FontWeight.w600,
                            fontSize: 15,maxLine: 50,
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 3.0,),
              Visibility(
                  visible: controller.selectedCommerce.value.facebook != null && controller.selectedCommerce.value.facebook != '',
                  child: InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(controller.selectedCommerce.value.facebook.toString()));
                    },
                    child: Row(
                      children: [
                        Image.asset(AppIcons.FACEBOOK, width: 20, height: 20,),
                        SizedBox(width: 3,),
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: TextWidget(text: controller.selectedCommerce.value.facebook.toString(), fontWeight: FontWeight.w600,
                            fontSize: 15,maxLine: 50,
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 3.0,),
              Visibility(
                  visible: controller.selectedCommerce.value.linkedln != null && controller.selectedCommerce.value.linkedln != '',
                  child: InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(controller.selectedCommerce.value.linkedln.toString()));
                    },
                    child: Row(
                      children: [
                        Image.asset(AppIcons.LINKEDIN, width: 20, height: 20,),
                        SizedBox(width: 3,),
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: TextWidget(text: controller.selectedCommerce.value.linkedln.toString(), fontWeight: FontWeight.w600,
                            fontSize: 15,maxLine: 50,
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 3.0,),
              Visibility(
                  visible: controller.selectedCommerce.value.instagram != null && controller.selectedCommerce.value.instagram != '',
                  child: InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(controller.selectedCommerce.value.instagram.toString()));
                    },
                    child: Row(
                      children: [
                        Image.asset(AppIcons.INSTAGRAM, width: 20, height: 20,),
                        SizedBox(width: 3,),
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: TextWidget(text: controller.selectedCommerce.value.instagram.toString(), fontWeight: FontWeight.w600,
                            fontSize: 15,maxLine: 50,
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 3.0,),
              Visibility(
                  visible: controller.selectedCommerce.value.youtube != null && controller.selectedCommerce.value.youtube != '',
                  child: InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(controller.selectedCommerce.value.youtube.toString()));
                    },
                    child: Row(
                      children: [
                        Image.asset(AppIcons.YOUTUBE, width: 20, height: 20,),
                        SizedBox(width: 3,),
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: TextWidget(text: controller.selectedCommerce.value.youtube.toString(), fontWeight: FontWeight.w600,
                            fontSize: 15,maxLine: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
              ),
              SizedBox(height: 5.0,),
              Row(
                children: [
                  Image.asset(ICON_NAME, width: 20, height: 20,),
                  SizedBox(width: 3,),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child: TextWidget(text: controller.selectedCommerce.value.responsable.toString().toUpperCase(), fontWeight: FontWeight.w600,
                      fontSize: 15,maxLine: 50, color: Colors.grey,
                    ),
                  ),
              
                ],
              ),
              SizedBox(height: 5,),
              InkWell(
                onTap: (){
                  controller.showAlerte(controller.selectedCommerce.value.contact.toString());
                },
                child: Row(
                  children: [
                    Image.asset(ICON_TELEPHONE, width: 20, height: 20,),
                    SizedBox(width: 3,),
                    TextWidget(text: controller.selectedCommerce.value.contact.toString(), fontWeight: FontWeight.bold, fontSize: 14,color: Colors.blue,),
                  ],
                ),
              ),
              SizedBox(height: 10.0,),
              // Container(
              //   width: double.infinity,
              //   height: 250,
              //   child: GestureDetector(
              //     child: ImageWidget(isNetWork: true, url:
              //     controller.selectedCommerce.value.imageUrl, width: 250, height: 250, fit: BoxFit.contain,
              //       default_image: DefaultImage.COMMERCE,
              //     ),
              //     onTap: (){
              //       zoomCtrl.setImageUrl(controller.selectedCommerce.value.imageUrl.toString());
              //       Get.to(ZoomView(), fullscreenDialog: true);
              //     },
              //   ),
                     Visibility(
                            visible: controller.selectedCommerce.value.moyenneRestaurant != null,
                            child: Row(
                              children: [
                                 Icon(Icons.notifications_on_sharp, color: Colors.blueGrey, size: 25),
                                SizedBox(width: 10.0,),
                                TextWidget(
                                  text: '${controller.selectedCommerce.value.moyenneRestaurant}',
                                  color: Colors.green,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  alignement: TextAlign.left,
                                ),
                                Icon(Icons.star_half_sharp, color: Colors.amber[800], size: 25),
                               Text('/ 5',
                                    style: TextStyle(
                                      color: Colors.green,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                 
                                    ),
                              ),
                              ],
                              
                            ),
                          ),
              // ), 
              CarouselSlider(
                      options: CarouselOptions(
                        enableInfiniteScroll: true,
                        autoPlayInterval: Duration(seconds: 5),
                        autoPlayAnimationDuration: Duration(milliseconds: 3500),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                      ),
                      items: generateSlider(listMedia),
                    ),
              SizedBox(height: 15.0,),
              Text(controller.selectedCommerce.value.description.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 150,
              ),
              Divider(),
              TextButton(
                onPressed: (){
                  // MapsLauncher.launchCoordinates(double.parse(controller.selectedCommerce.value.longitude!), double.parse(controller.selectedCommerce.value.latitude!), controller.selectedCommerce.value.nom);
                  launchUrl(Uri.parse(controller.selectedCommerce.value.lien.toString()));
                },
                child: Row(
                  children: [
                    Icon(Icons.map, color: Colors.red,),
                    TextWidget(text:"Itinéraire",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
              Divider(),
                          SizedBox(height: 20.0),
                          Text(
                            "Avez-vous déjà séjournez dans ce Hôtel?. Si oui, donnez une note svp.",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 7.0),

//rating
                          Obx(()=>RatingBar.builder(
                            initialRating: controller.rating.value,
                            minRating: 1,
                            itemCount: 5,
                            direction: Axis.horizontal,
                            itemBuilder: (context, index) {
                              switch (index) {
                                case 0:
                                  return Icon(
                                    Icons.sentiment_very_dissatisfied,
                                    color: Colors.red,
                                  );
                                case 1:
                                  return Icon(
                                    Icons.sentiment_dissatisfied,
                                    color: Colors.redAccent,
                                  );
                                case 2:
                                  return Icon(
                                    Icons.sentiment_satisfied_alt_outlined,
                                    color: Colors.amber,
                                  );
                                case 3:
                                  return Icon(
                                    Icons.sentiment_very_satisfied,
                                    color: Colors.lightGreen,
                                  );
                                case 4:
                                  return Icon(
                                    Icons.sentiment_very_satisfied_sharp,
                                    color: Colors.green,
                                  );
                                default:
                                  return Icon(
                                    Icons
                                        .sentiment_very_dissatisfied_sharp, // Vous pouvez choisir un autre icône par défaut.
                                    color: Colors
                                        .grey, // Vous pouvez choisir une autre couleur par défaut.
                                  );
                              }
                            },
                            onRatingUpdate: (rating) {
                              print('valeur: $rating');
                              controller.rating.value = rating;
                             
                            },
                          )),
                          SizedBox(height: 20.0),
                          TextField(
                            maxLines:
                                null, // Pour permettre plusieurs lignes de texte
                            keyboardType: TextInputType
                                .multiline, // Pour activer le clavier avec plusieurs lignes
                            decoration: InputDecoration(
                              labelText: 'Entrez votre commentaire',
                              hintText:
                                  'Entrez votre avis ici', // Texte d'exemple qui s'affiche quand le champ est vide
                              border:
                                  OutlineInputBorder(), // Pour ajouter une bordure autour de la zone de texte
                            ),
                            controller:controller.commentaire.value ,
                          ),
                          SizedBox(height: 15.0),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
  ElevatedButton(
                            onPressed: () {
                              // Utilisez cette fonction pour traiter les données du champ de texte lorsque le bouton est cliqué.
                              // Maintenant, vous pouvez accéder à controller.rating et controller.textFieldValue ici.
                              print('Note : ${controller.rating.value}');
                              print('Commentaire : ${controller.commentaire.value.text}');
                               print('Restaurant_id : ${controller.selectedCommerce.value.id}');
                              print('utilsateur :${authentification.user_id.value}');
                              var noteModel = CommentaireNote();
                              noteModel.valeur = controller.rating.value;
                               noteModel.restaurantId = controller.selectedCommerce.value.id;
                              noteModel.texte = controller.commentaire.value.text;
                              noteModel.userId = authentification.user_id.value;
                              controller.examen(noteModel);
                               showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Merci Votre Note!!'),
                                        content: Text('La note est ${ controller.rating.value}/5'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Fermer'),
                                          ),
                                        ],
                                      );
                                    },
                                );
                            },
                            child: Text(
                              'Valider',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                           
                           
                            BottomSheetExample(restaurant_id:controller.selectedCommerce.value.id!),
                        
                            ],
                          ),
                        
            ],
          ),
        ),
      ),
    );
  }

}
class BottomSheetExample extends StatelessWidget {
  final int restaurant_id;
  const BottomSheetExample({Key? key, required this.restaurant_id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    RestaurantController restaurantController = Get.put(RestaurantController());
    return Center(
      child: ElevatedButton(
        child: const Text('Voir les commentaires'),
        onPressed: () {
          restaurantController.afficheNoteCommtaire(restaurant_id);
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 500,
                  child: Obx(() => restaurantController.isDataProcessing.value
              ? LoadingWidget()
              : restaurantController.restaurantNoteCommentaire.isEmpty
                  ? NoDataWidget()
                  : ListView.builder(
                      itemCount: restaurantController.restaurantNoteCommentaire.length,
                      itemBuilder: (BuildContext context, int index) {
                        final restaurantNoteCommentaire = restaurantController.restaurantNoteCommentaire[index];
                       return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Row(
                                            children: <Widget>[
                                Text('${restaurantNoteCommentaire.user!.pseudo.toString()}'),
                                 SizedBox(width: 25),
                                Visibility(
                                visible:restaurantNoteCommentaire.valeur!=null ,
                                child: TextWidget(
                                text: '${restaurantNoteCommentaire.valeur.toString()}',
                                color: Colors.green,
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                                alignement: TextAlign.left,
                                ) ,
                              ),
                             
                             Visibility(
                                visible:restaurantNoteCommentaire.valeur!=null ,
                                child:  Icon(Icons.star_half_sharp, color:Colors.amber[800], size:25)
                               ) 
                                            ],
                                          ),
                                          content: Text(restaurantNoteCommentaire.texte!),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Get.back(); // Pour fermer le dialogue
                                              },
                                              child: Text('Fermer'),
                                              style:TextButton.styleFrom(
                                                       primary: Colors.red, // Couleur du texte du bouton
                                                ), 
                                            ),
                                          ],
                                        );
                                      },);
                              },
                              title: TextWidget(
                                text: restaurantNoteCommentaire.user!.pseudo.toString(),
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                alignement: TextAlign.left,
                              ),
                              subtitle: Row(
                                children: <Widget>[
                                   Visibility(
                                 visible:restaurantNoteCommentaire.valeur!=null ,
                                child: TextWidget(
                                text:truncateText(restaurantNoteCommentaire.texte.toString(), 15),
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                alignement: TextAlign.left,
                                ) ,
                              ),
                              SizedBox(width: 5.0),
                               Visibility(
                                visible:restaurantNoteCommentaire.valeur!=null ,
                                child: TextWidget(
                                text: ' - ',
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                alignement: TextAlign.left,
                                ) ,
                              ),
                              SizedBox(width: 5.0),
                               Visibility(
                                visible:restaurantNoteCommentaire.valeur!=null ,
                                child: TextWidget(
                                text: '${restaurantNoteCommentaire.valeur.toString()}',
                                color: Colors.green,
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                                alignement: TextAlign.left,
                                ) ,
                              ),
                             Visibility(
                                visible:restaurantNoteCommentaire.valeur!=null ,
                                child:  Icon(Icons.star_half_sharp, color:Colors.amber[800], size:25)
                               )    
                              ],),
                              leading: Icon(Icons.comment_bank_rounded),
                              trailing: Icon(Icons.arrow_right),
                            ),
                          ],
                        );
                          })
                )   
              );
            },
          );
        },
      ),
    );
  }
    String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + '...';
    }
  }


}
