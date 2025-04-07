import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

void quickAlertDialog(BuildContext context, QuickAlertType type,
    {Color? color,
    String? title,
    String? message,
    VoidCallback? onConfirmBtnTap}) {
  QuickAlert.show(
      context: context,
      type: type,
      text: message,
      title: title,
      headerBackgroundColor: color!,
      confirmBtnColor: color,
      onConfirmBtnTap: onConfirmBtnTap,
      onCancelBtnTap: () {
        Navigator.of(context).pop();
      });
}
