import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontStyle fontStyle;
  final FontWeight weight;
  final TextAlign align;
  final Color color;

  const AppText(
    this.text, {
    this.fontStyle = FontStyle.normal,
    this.weight = FontWeight.normal,
    this.align = TextAlign.start,
    this.color = Colors.black87,
    this.fontSize = 15,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      key: key,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontWeight: weight,
        fontStyle: fontStyle,
        fontSize: fontSize,
      ),
    );
  }
}
