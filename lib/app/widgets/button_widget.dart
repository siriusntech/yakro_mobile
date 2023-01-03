import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextButtonWidget extends StatelessWidget {
  TextButtonWidget({this.action, required this.text_widget, this.border_side, this.rounded});

  VoidCallback? action;
  Widget text_widget;
  MaterialStateProperty<BorderSide>? border_side;
  MaterialStateProperty<RoundedRectangleBorder>? rounded;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: action,
        child: text_widget,
        style: ButtonStyle(
            side: border_side,
            shape: rounded
        )
    );
  }
}
