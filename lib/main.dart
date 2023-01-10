import 'package:flutter/material.dart';
import 'package:tele_tip/ui/loginPage/login.dart';
import 'package:tele_tip/ui/registerPage/register_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => const RolePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RolePage(),
      },
    );
  }
}
