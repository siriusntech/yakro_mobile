import 'package:flutter/material.dart';


// ignore: must_be_immutable
class TextWidget extends StatelessWidget {

  TextWidget({
    this.text, this.color,
    this.fontSize, this.fontWeight,
    this.alignement, this.scaleFactor,
    this.maxLine, this.overFlow,
    this.fontStyle,
    this.decoration,
  });

  String? text;
  Color? color;
  double? fontSize;
  double? scaleFactor;
  FontWeight? fontWeight;
  FontStyle? fontStyle;
  TextAlign? alignement;
  int? maxLine;
  TextOverflow? overFlow;
  TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(text!,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
        decoration: decoration,
      ),
      textAlign: alignement,
      textScaleFactor: scaleFactor,
      maxLines: maxLine,
      overflow: overFlow,
 
    );
  }
}

// ignore: must_be_immutable
class SelectableTextWidget extends StatelessWidget {

  SelectableTextWidget({this.text, this.color, this.fontSize, this.fontWeight, this.alignement, this.scaleFactor, this.maxLine, this.decoration,});

  String? text;
  Color? color;
  double? fontSize;
  double? scaleFactor;
  FontWeight? fontWeight;
  TextAlign? alignement;
  int? maxLine;
  TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return SelectableText(text!,
      // showCursor: true,
      cursorWidth: 4,
      cursorColor: Colors.blue,
      cursorRadius: Radius.circular(5),
      scrollPhysics: ClampingScrollPhysics(),
      style: TextStyle(color: color, fontSize: fontSize,fontWeight: fontWeight, overflow: TextOverflow.ellipsis,decoration:decoration,),
      textAlign: alignement,
      textScaleFactor: scaleFactor,
      maxLines: maxLine,
  
    );
  }
}