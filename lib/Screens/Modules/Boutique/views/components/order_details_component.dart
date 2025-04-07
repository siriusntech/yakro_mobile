import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Helpers/helpers.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class OrderDetailsComponent extends StatelessWidget {
  const OrderDetailsComponent({super.key, required this.orderBoutiqueModel});
  final OrderBoutiqueModel? orderBoutiqueModel;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Panier (${orderBoutiqueModel!.orderNumber})',
            style: TextStyle(
                fontSize: 20, fontFamily: GoogleFonts.padauk().fontFamily)),
        content: Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          '${AppConfig.baseUrl}${orderBoutiqueModel!.cartBoutiques![index].produitBoutiques![0].produitMedias![0].url!}'),
                    ),
                    subtitle: Text(
                      "${Helpers.formatPrice(double.parse(orderBoutiqueModel!.cartBoutiques![index].price.toString()))} F X ${orderBoutiqueModel!.cartBoutiques![index].quantity}",
                    ),
                    trailing: Text(
                      "${Helpers.formatPrice(double.parse(orderBoutiqueModel!.cartBoutiques![index].amount.toString()))} F",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    title: Text(orderBoutiqueModel!
                        .cartBoutiques![index].produitBoutiques![0].libelle!),
                  ),
                  itemCount: orderBoutiqueModel!.cartBoutiques!.length,
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ),
              Text(
                'Date Livraison: ${orderBoutiqueModel!.jourLivraison}',
                style: TextStyle(
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Text(
                'Livraison: ${Helpers.formatPrice(double.parse(orderBoutiqueModel!.shippingBoutiqueModel!.prix.toString()))} F',
                style: TextStyle(
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              )
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Color(0xff931F22))),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Fermer',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: GoogleFonts.padauk().fontFamily,
                    color: Colors.white)),
          )
        ]);
  }
}
