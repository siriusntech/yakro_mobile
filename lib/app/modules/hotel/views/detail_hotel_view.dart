import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/app/models/CommentaireNote.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controllers/main_controller.dart';
import '../../../models/hotelAll.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../home/views/home_view.dart';
import '../controllers/hotel_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailHotelView extends GetView {
  final HotelModel data;
  const DetailHotelView({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HotelController hotelController = Get.put(HotelController());
    final MainController settingsCtrl = Get.find();
    final AuthController authentification = Get.put(AuthController());
    // hotelController.hotel_id.value = data.id ?? 0;
    List listMedia = data.hotelsMedias!.map((element) {
      return element!.url;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.vert_color_fonce,
        title: TextWidget(
          text: 'Détail de l\'hotel',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await hotelController.refreshData();
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: Obx(() {
        return hotelController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                flex: 5,
                                child: Text(
                                  data.nomHotel!,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 25.0),
                              Flexible(
                                  flex: 0,
                                  child: Icon(Icons.star_half_sharp,
                                      color: Colors.amber[800], size: 25)),
                              Flexible(
                                flex: 0,
                                child: Visibility(
                                  visible: data.moyenneHotel != null,
                                  child: TextWidget(
                                    text: '${data.moyenneHotel} /5',
                                    color: Colors.green,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w900,
                                    alignement: TextAlign.left,
                                  ),
                                ),
                              )
                            ],
                          ),

                          SizedBox(height: 10),
                          Text(
                            data.description!,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 20),
                          Visibility(
                              visible: data.typeQuartierHotelsId != null,
                              child: TextField(
                                controller: TextEditingController(
                                    text:
                                        '${data.typeQuartierHotelsId!.toString()}'),
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: 'Lieu',
                                  prefixIcon: Icon(FontAwesomeIcons.map),
                                  border: OutlineInputBorder(),
                                ),
                              )),
                          SizedBox(height: 10),
                          TextField(
                            controller: TextEditingController(
                                text: '${data.typeHotelId?.toString()}'),
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Type d`\'hotel',
                              prefixIcon: Icon(FontAwesomeIcons.hotel),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller:
                                TextEditingController(text: '${data.prix} CFA'),
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Prix',
                              prefixIcon: Icon(FontAwesomeIcons.moneyBillWave),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),

                          InkWell(
                            onTap: () {
                              hotelController
                                  .showAlerte(data.numeroHotel.toString());
                            },
                            child: TextField(
                              controller:
                                  TextEditingController(text: data.numeroHotel),
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: 'Numéro 1',
                                prefixIcon: Icon(FontAwesomeIcons.phone),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              // Action à effectuer lorsque le TextField est tapé
                              // Insérez votre code ici
                              print('TextField tapé !');
                              hotelController
                                  .showAlerte(data.contact.toString());
                            },
                            child: TextField(
                              controller:
                                  TextEditingController(text: data.contact),
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: 'Numéro 2',
                                prefixIcon: Icon(FontAwesomeIcons.mobile),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              // Action à effectuer lorsque le TextField est tapé
                              // Insérez votre code ici
                              print('TextField tapé !');
                              launchUrl(Uri.parse(data.lienMap.toString()));
                            },
                            child: TextField(
                              controller: TextEditingController(text: ' '),
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: 'Lien de map',
                                prefixIcon: Icon(FontAwesomeIcons.mapLocation),
                                border: OutlineInputBorder(),
                                prefixText: 'Itinéraire',
                                prefixStyle: TextStyle(
                                  color: Colors.red, // Couleur du texte
                                  fontSize: 17.0, // Taille de la police
                                  fontWeight: FontWeight
                                      .bold, // Style de la police en gras
                                  // Vous pouvez ajouter d'autres propriétés de style ici si nécessaire
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              // Action à effectuer lorsque le TextField est tapé
                              // Insérez votre code ici
                              print('TextField tapé !');
                              launchUrl(Uri.parse(data.linkedIn.toString()));
                            },
                            child: TextField(
                              controller:
                                  TextEditingController(text: data.linkedIn),
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: 'LinkedIn',
                                prefixIcon: Icon(FontAwesomeIcons.linkedinIn),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),

                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              // Action à effectuer lorsque le TextField est tapé
                              // Insérez votre code ici
                              print('TextField tapé !');
                              launchUrl(Uri.parse(data.instagram.toString()));
                            },
                            child: TextField(
                              controller:
                                  TextEditingController(text: data.instagram),
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: 'Instagram',
                                prefixIcon: Icon(FontAwesomeIcons.instagram),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              // Action à effectuer lorsque le TextField est tapé
                              // Insérez votre code ici
                              launchUrl(
                                  Uri.parse(data.siteInternet.toString()));
                            },
                            child: TextField(
                              controller: TextEditingController(
                                  text: data.siteInternet),
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: 'Site Internet',
                                prefixIcon:
                                    Icon(FontAwesomeIcons.internetExplorer),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),

                          SizedBox(height: 10),
                          InkWell(
                              onTap: () {
                                // Action à effectuer lorsque le TextField est tapé
                                // Insérez votre code ici
                                launchUrl(Uri.parse(data.facebook.toString()));
                              },
                              child: TextField(
                                  controller: TextEditingController(
                                      text: data.facebook),
                                  enabled: false,
                                  decoration: InputDecoration(
                                    labelText: 'Facebook',
                                    prefixIcon: Icon(FontAwesomeIcons.facebook),
                                    border: OutlineInputBorder(),
                                  ))),
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
                            initialRating: hotelController.rating.value,
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
                              hotelController.rating.value = rating;
                             
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
                            controller:hotelController.commentaire.value ,
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
                              print('Note : ${hotelController.rating.value}');
                              print('Commentaire : ${hotelController.commentaire.value.text}');
                              print('Hotel_id : ${data.id}');
                              print('utilsateur :${authentification.user_id.value}');
                              var noteModel = CommentaireNote();
                              noteModel.valeur = hotelController.rating.value;
                              noteModel.hotelId = data.id;
                              noteModel.texte = hotelController.commentaire.value.text;
                              noteModel.userId = authentification.user_id.value;
                              hotelController.examen(noteModel);
                               showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Merci Votre Note!!'),
                                        content: Text('La note est ${ hotelController.rating.value}/5'),
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
                           
                           
                           BottomSheetExample(hotel_id:data.id!),
                        
                            ],
                          ),
                        
                        ],
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
class BottomSheetExample extends StatelessWidget {
  final int hotel_id;
  const BottomSheetExample({Key? key, required this.hotel_id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HotelController hotelController = Get.put(HotelController());
    return Center(
      child: ElevatedButton(
        child: const Text('Voir les commentaires'),
        onPressed: () {
          hotelController.afficheNoteCommtaire(hotel_id);
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 500,
                  child: Obx(() => hotelController.isDataProcessing.value
              ? LoadingWidget()
              : hotelController.hotelNoteCommentaire.isEmpty
                  ? NoDataWidget()
                  : ListView.builder(
                    itemCount: hotelController.hotelNoteCommentaire.length,
                    itemBuilder: (BuildContext context, int index) {
                      final hotelNoteCommentaire = hotelController.hotelNoteCommentaire[index];
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
                              Text('${hotelNoteCommentaire.user!.nom.toString()}'),
                               SizedBox(width: 25),
                              Visibility(
                              visible:hotelNoteCommentaire.valeur!=null ,
                              child: TextWidget(
                              text: '${hotelNoteCommentaire.valeur.toString()}',
                              color: Colors.green,
                              fontSize: 19,
                              fontWeight: FontWeight.w900,
                              alignement: TextAlign.left,
                              ) ,
                            ),
                           
                           Visibility(
                              visible:hotelNoteCommentaire.valeur!=null ,
                              child:  Icon(Icons.star_half_sharp, color:Colors.amber[800], size:25)
                             ) 
                                          ],
                                        ),
                                        content: Text(hotelNoteCommentaire.texte!),
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
                              text: hotelNoteCommentaire.user!.nom.toString(),
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              alignement: TextAlign.left,
                            ),
                            subtitle: Row(
                              children: <Widget>[
                                 Visibility(
                               visible:hotelNoteCommentaire.valeur!=null ,
                              child: TextWidget(
                              text:truncateText(hotelNoteCommentaire.texte.toString(), 15),
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              alignement: TextAlign.left,
                              ) ,
                            ),
                            SizedBox(width: 5.0),
                             Visibility(
                              visible:hotelNoteCommentaire.valeur!=null ,
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
                              visible:hotelNoteCommentaire.valeur!=null ,
                              child: TextWidget(
                              text: '${hotelNoteCommentaire.valeur.toString()}',
                              color: Colors.green,
                              fontSize: 19,
                              fontWeight: FontWeight.w900,
                              alignement: TextAlign.left,
                              ) ,
                            ),
                           Visibility(
                              visible:hotelNoteCommentaire.valeur!=null ,
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


