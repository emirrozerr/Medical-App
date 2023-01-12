import 'package:flutter/material.dart';
import 'package:tele_tip/ui/homePage/home_page.dart';
import 'package:tele_tip/ui/loginPage/login.dart';
import 'package:tele_tip/ui/messagePage/chat_details.dart';
import 'package:tele_tip/ui/messagePage/chat_list.dart';
import 'package:tele_tip/ui/registerPage/register_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const LoginPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/detailedMsg': (context) => const ChatDetailPage(),
        '/msgBox': (context) => const ChatListPage(),
      },
    );
  }
}
