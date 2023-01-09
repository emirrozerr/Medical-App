import 'package:flutter/material.dart';
import 'package:tele_tip/ui/loginPage/login.dart';
import 'package:tele_tip/ui/registerPage/register_page.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}
