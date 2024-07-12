import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

Widget cText(
  String text,
  String font, {
  Color color = Colors.white,
  double fontSize = 18,
  FontWeight fontWeight = FontWeight.w400,
}) {
  return Text(
    text,
    style: GoogleFonts.getFont(
      font,
      textStyle: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    ),
  );
}
