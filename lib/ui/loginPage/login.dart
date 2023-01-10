import 'package:flutter/material.dart';
import 'package:tele_tip/ui/app_colors.dart';

import 'package:tele_tip/ui/registerPage/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool isAPIcallProcess = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(backgroundColor: newLogoBeige, body: _loginUI(context)));
  }

  Widget _loginUI(BuildContext context) {
    return ListView(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        logoWidget(context),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 50),
            child: Text(
              "Hoş Geldiniz",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: newLogoBrown),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: TextFormField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: "E-Mail",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                suffixIcon: Icon(
                  Icons.person,
                  color: Colors.white.withOpacity(0.7),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white))),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email alanı boş olamaz.";
              }
              return null;
            },
            onSaved: null,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: TextFormField(
            style: const TextStyle(color: Colors.white),
            obscureText: hidePassword,
            decoration: InputDecoration(
                hintText: "Şifre",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white)),
                suffixIcon: IconButton(
                  icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                )),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Şifre alanı boş olamaz.";
              }
              return null;
            },
            onSaved: null,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: RawMaterialButton(
              onPressed: (() {}),
              fillColor: newLogoRed,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                "Giriş Yap",
                style:
                    TextStyle(color: buttonText, fontWeight: FontWeight.bold),
              )),
        ),
        const SizedBox(
          height: 35,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Hesabın yok mu?   ",
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RolePage()));
                  },
                  child: const Text(
                    "Kayıt Ol",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}

Widget logoWidget(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height / 3,
    decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.white]),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100),
            bottomRight: Radius.circular(100))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/logo.png",
            width: 150,
            fit: BoxFit.contain,
          ),
        )
      ],
    ),
  );
}
