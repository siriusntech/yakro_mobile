import 'package:flutter/material.dart';
import 'package:jaime_yakro/Helpers/helpers.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';

class CardOrderElement extends StatelessWidget {
  const CardOrderElement({super.key, required this.orderBoutiqueModel});
  final OrderBoutiqueModel? orderBoutiqueModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) =>
                OrderDetailsComponent(orderBoutiqueModel: orderBoutiqueModel));
      },
      child: ListTile(
        title: Text(orderBoutiqueModel!.orderNumber!),
        subtitle: Text(
            '${Helpers.formatDateHour(orderBoutiqueModel!.createdAt.toString())}'),
        trailing: Text('${orderBoutiqueModel!.totalAmount} F'),
      ),
    );
  }
}
