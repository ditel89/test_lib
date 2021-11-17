import 'package:flutter/material.dart';

class Style {
  static final baseTextSt = const TextStyle(fontFamily: 'Poppins');
  static final smallTextSt =
      baseTextSt.copyWith(color: Colors.white, fontSize: 9.0);
  static final commonTextSt = baseTextSt.copyWith(
      color: const Color(0xffb6b2df),
      fontSize: 14.0,
      fontWeight: FontWeight.w400);
  static final titleTextSt = baseTextSt.copyWith(
      color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);
  static final headerTextSt = baseTextSt.copyWith(
      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w400);
}
