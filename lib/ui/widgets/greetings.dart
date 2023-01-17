import 'package:flutter/material.dart';
import 'package:tele_tip/app_colors.dart';

Widget greetings() {
  DateTime now = DateTime.now();
  int hour = now.hour;
  if (hour < 6) {
    return Text(
      "İyi Geceler, ",
      style: TextStyle(fontSize: 25, color: logoRed),
    );
  } else if (hour < 12) {
    return Text(
      "Günaydın, ",
      style: TextStyle(fontSize: 25, color: logoRed),
    );
  } else if (hour < 18) {
    return Text(
      "İyi Günler, ",
      style: TextStyle(fontSize: 25, color: logoRed),
    );
  } else {
    return Text(
      "İyi Akşamlar, ",
      style: TextStyle(fontSize: 25, color: logoRed),
    );
  }
}
