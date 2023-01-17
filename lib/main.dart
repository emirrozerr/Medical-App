import 'package:flutter/material.dart';
import 'package:tele_tip/services/shared_service.dart';
import 'package:tele_tip/ui/homePage/home_tabs.dart';
import 'package:tele_tip/ui/loginPage/login.dart';
import 'package:tele_tip/ui/messagePage/chat_list.dart';
import 'package:tele_tip/ui/registerPage/doctor_register.dart';
import 'package:tele_tip/ui/registerPage/register_page.dart';

Widget _default = const LoginPage();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool _result = await SharedService.isLoggedIn();

  if (_result) {
    _default = const HomePage();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tele Tıp',
      routes: {
        '/': (context) => _default,
        '/home': (context) => const HomePage(),
        '/userLogin': (context) => const LoginPage(),
        '/userRegister': (context) => const RegisterPage(),
        '/details': (context) => const MessagePage(),
        '/doctorRegister': (context) => const DoctorRegisterPage()
      },
    );
  }
}
