import 'package:flutter/material.dart';
import 'package:tele_tip/ui/app_colors.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = false;
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
        const Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 30, top: 50),
            child: Text(
              "Hoş Geldiniz",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            ),
          ),
        ),
        FormHelper.inputFieldWidget(context, "email", "E-mail",
            (onValidateVal) {
          if (onValidateVal.isEmpty) {
            return "Email adresi boş olamaz";
          }
          return null;
        }, (onSavedVal) {},
            borderFocusColor: Colors.white,
            prefixIconColor: Colors.white,
            suffixIcon: Icon(
              Icons.person,
              color: Colors.white.withOpacity(0.7),
            ),
            borderColor: Colors.white,
            textColor: Colors.white,
            hintColor: Colors.white.withOpacity(0.7),
            borderRadius: 10),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: FormHelper.inputFieldWidget(context, "password", "Şifre",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return "Şifre boş olamaz";
            }
            return null;
          }, (onSavedVal) {},
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              obscureText: hidePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                icon: Icon(
                    hidePassword ? Icons.visibility : Icons.visibility_off),
                color: Colors.white.withOpacity(0.7),
              ),
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10),
        ),
        const SizedBox(
          height: 40,
        ),
        Center(
          child: FormHelper.submitButton("Giriş yap", () {},
              btnColor: newLogoRed,
              borderColor: newLogoPink,
              txtColor: newLogoPink,
              borderRadius: 10),
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
                    Navigator.pushNamed(context, "/register");
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
