import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:tele_tip/app_colors.dart';
import 'package:tele_tip/config.dart';
import 'package:tele_tip/models/user_register_req.dart';
import 'package:tele_tip/components/or_divider.dart';
import 'package:tele_tip/services/api_service.dart';

class DoctorRegisterPage extends StatefulWidget {
  const DoctorRegisterPage({Key? key}) : super(key: key);

  @override
  DoctorRegisterPageState createState() => DoctorRegisterPageState();
}

class DoctorRegisterPageState extends State<DoctorRegisterPage> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFromKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? name;
  String? surname;
  String phone = "530 000 00 00";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundBeige,
        body: ProgressHUD(
          child: Form(
            key: globalFromKey,
            child: _registerUI(context),
          ),
          key: UniqueKey(),
          inAsyncCall: isAPIcallProcess,
          opacity: 0.3,
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 5,
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
        ),
        const Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 30, top: 50),
            child: Text(
              "Kayıt Ol",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            ),
          ),
        ),
        FormHelper.inputFieldWidget(context, "name", "Adınız", (onValidateVal) {
          if (onValidateVal.isEmpty) {
            return "Lütfen adınızı giriniz!";
          }
          return null;
        }, (onSavedVal) {
          name = onSavedVal;
        },
            borderFocusColor: Colors.white,
            prefixIconColor: Colors.white,
            borderColor: Colors.white,
            textColor: Colors.white,
            hintColor: Colors.white.withOpacity(0.7),
            borderRadius: 10),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: FormHelper.inputFieldWidget(context, "surname", "Soyadınız",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return "Lütfen Soyadınızı giriniz.";
            }
            return null;
          }, (onSavedVal) {
            surname = onSavedVal;
          },
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: FormHelper.inputFieldWidget(context, "email", "E-mail",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return "Email adresi boş olamaz";
            }
            return null;
          }, (onSavedVal) {
            email = onSavedVal;
          },
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: FormHelper.inputFieldWidget(context, "password", "Şifre",
              (onValidateVal) {
            if (onValidateVal.length < 6) {
              return "Şifre 6 karakterden küçük olamaz";
            }
            return null;
          }, (onSavedVal) {
            password = onSavedVal;
          },
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
          child: FormHelper.submitButton("Kayıt ol", () {
            if (validateAndSave()) {
              setState(() {
                isAPIcallProcess = true;
              });
              UserRegisterReqModel model = UserRegisterReqModel(
                  email: email!,
                  password: password!,
                  name: name!,
                  surname: surname!,
                  phone: phone);
              APIService.userRegister(model).then((res) {
                if (res.success) {
                  setState(() {
                    isAPIcallProcess = false;
                  });
                  FormHelper.showSimpleAlertDialog(context, Config.appName,
                      "Kayıt Başarılı. Giriş Yapabilirsiniz", "Tamam", () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/userLogin', (route) => false);
                  });
                } else {
                  setState(() {
                    isAPIcallProcess = false;
                  });
                  FormHelper.showSimpleAlertDialog(
                      context, Config.appName, res.msg, "Tamam", () {
                    Navigator.pop(context);
                  });
                  // FormHelper.showSimpleAlertDialog(
                  //     context, Config.appName, res.msg, "Tamam", () {
                  //   Navigator.pushNamedAndRemoveUntil(
                  //       context, '/userRegister', (route) => false);
                  // });
                }
              });
            }
          },
              btnColor: newDarkRed,
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10),
        ),
        const SizedBox(
          height: 15,
        ),
        const Center(child: OrDivider()),
        Center(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.grey, fontSize: 14),
              children: <TextSpan>[
                const TextSpan(
                  text: "Bir hesabın var mı o halde?",
                  style: TextStyle(color: Colors.white),
                ),
                TextSpan(
                    text: " Giriş Yap",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, "/userLogin");
                      })
              ],
            ),
          ),
        ),
      ],
    ));
  }

  bool validateAndSave() {
    final form = globalFromKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
