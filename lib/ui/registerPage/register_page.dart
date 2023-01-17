import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:tele_tip/app_colors.dart';
import 'package:tele_tip/config.dart';
import 'package:tele_tip/models/doc_register_req.dart';
import 'package:tele_tip/models/user_register_req.dart';
import 'package:tele_tip/services/api_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  bool isAPIcallProcess = false;
  GlobalKey<FormState> globalFromKey = GlobalKey<FormState>();

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundBeige,
        body: ProgressHUD(
          key: UniqueKey(),
          inAsyncCall: isAPIcallProcess,
          opacity: 0.3,
          child: Form(
            key: globalFromKey,
            child: SingleChildScrollView(
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30, top: 50),
                    child: Text(
                      "Kayıt Ol",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: newDarkRed),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RawMaterialButton(
                      onPressed: (() {
                        setState(() {
                          index = 0;
                        });
                      }),
                      fillColor: logoRed,
                      focusColor: newDarkRed.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: const Text(
                        "Hasta",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    RawMaterialButton(
                      onPressed: (() {
                        setState(() {
                          index = 1;
                        });
                      }),
                      fillColor: logoRed,
                      focusColor: newDarkRed.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: const Text(
                        "Doktor",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                index == 1
                    ? DoctorTab(
                        validate: validateAndSave,
                        onSaved: (val) {
                          setState(() {
                            isAPIcallProcess = val;
                          });
                        },
                      )
                    : PatientTab(
                        validate: validateAndSave,
                        onSaved: (p0) {
                          setState(() {
                            isAPIcallProcess = p0;
                          });
                        },
                      ),
              ],
            )),
          ),
        ),
      ),
    );
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

class PatientTab extends StatefulWidget {
  final bool Function() validate;
  final void Function(bool) onSaved;
  const PatientTab({super.key, required this.validate, required this.onSaved});

  @override
  State<PatientTab> createState() => _PatientTabState();
}

class _PatientTabState extends State<PatientTab> {
  bool hidePassword = true;
  GlobalKey<FormState> globalFromKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? name;
  String? surname;
  String? hospital;
  String? school;
  String phone = "530 000 00 00";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormHelper.inputFieldWidget(context, "name", "Adınız", (onValidateVal) {
          if (onValidateVal.isEmpty) {
            return "Lütfen adınızı giriniz.";
          }
          return null;
        }, (onSavedVal) {
          name = onSavedVal;
        },
            borderFocusColor: Colors.white,
            prefixIconColor: Colors.white,
            borderColor: Colors.white,
            textColor: Colors.grey.withOpacity(0.8),
            hintColor: Colors.grey.withOpacity(0.8),
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
              textColor: Colors.grey.withOpacity(0.8),
              hintColor: Colors.grey.withOpacity(0.8),
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
              textColor: Colors.grey.withOpacity(0.8),
              hintColor: Colors.grey.withOpacity(0.8),
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
              textColor: Colors.grey.withOpacity(0.8),
              obscureText: hidePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                icon: Icon(
                    hidePassword ? Icons.visibility : Icons.visibility_off),
                color: Colors.grey.withOpacity(0.8),
              ),
              hintColor: Colors.grey.withOpacity(0.8),
              borderRadius: 10),
        ),
        const SizedBox(
          height: 40,
        ),
        FormHelper.submitButton("Kayıt Ol", () {
          if (widget.validate()) {
            widget.onSaved(true);
            UserRegisterReqModel model = UserRegisterReqModel(
              email: email!,
              password: password!,
              name: name!,
              surname: surname!,
              phone: phone,
            );
            APIService.userRegister(model).then((res) {
              if (res.success) {
                widget.onSaved(false);
                FormHelper.showSimpleAlertDialog(context, Config.appName,
                    "Kayıt Başarılı. Giriş Yapabilirsiniz", "Tamam", () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/userLogin', (route) => false);
                });
              } else {
                widget.onSaved(false);
                FormHelper.showSimpleAlertDialog(
                    context, Config.appName, res.msg, "Tamam", () {
                  Navigator.pop(context);
                });
              }
            });
          }
        },
            btnColor: newDarkRed,
            borderColor: newDarkRed,
            txtColor: Colors.white,
            borderRadius: 30),
        const SizedBox(
          height: 15,
        ),
        Center(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.grey, fontSize: 14),
              children: <TextSpan>[
                const TextSpan(
                  text: "Bir hesabın var mı?",
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
    );
  }
}

class DoctorTab extends StatefulWidget {
  final bool Function() validate;
  final void Function(bool val) onSaved;
  const DoctorTab({super.key, required this.validate, required this.onSaved});

  @override
  State<DoctorTab> createState() => _DoctorTabState();
}

class _DoctorTabState extends State<DoctorTab> {
  bool hidePassword = true;

  String? email;
  String? password;
  String? name;
  String? surname;
  String? hospital;
  String? school;
  String phone = "530 000 00 00";

  var listeProf = <String>[
    'Seç',
    'Bel Fıtığı',
    'Boyun Fıtığı',
    'Omurilik Felci',
    'Optik',
  ];
  String dropdownValue = 'Seç';
  String dropdownValue2 = 'Seç';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Column(
        children: [
          FormHelper.inputFieldWidget(context, "name", "Adınız",
              (onValidateVal) {
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
              textColor: Colors.grey.withOpacity(0.8),
              hintColor: Colors.grey.withOpacity(0.8),
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
                textColor: Colors.grey.withOpacity(0.8),
                hintColor: Colors.grey.withOpacity(0.8),
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
                textColor: Colors.grey.withOpacity(0.8),
                hintColor: Colors.grey.withOpacity(0.8),
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
                textColor: Colors.grey.withOpacity(0.8),
                obscureText: hidePassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  icon: Icon(
                      hidePassword ? Icons.visibility : Icons.visibility_off),
                  color: Colors.grey.withOpacity(0.8),
                ),
                hintColor: Colors.grey.withOpacity(0.8),
                borderRadius: 10),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
                context, "school", "Mezun Olunan Okul", (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Lütfen okulunuzu giriniz.";
              }
              return null;
            }, (onSavedVal) {
              school = onSavedVal;
            },
                borderFocusColor: Colors.white,
                prefixIconColor: Colors.white,
                borderColor: Colors.white,
                textColor: Colors.grey.withOpacity(0.8),
                hintColor: Colors.grey.withOpacity(0.8),
                borderRadius: 10),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
                context, "hospital", "Çalıştığınız Hastane", (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Lütfen hastanenizi giriniz.";
              }
              return null;
            }, (onSavedVal) {
              hospital = onSavedVal;
            },
                borderFocusColor: Colors.white,
                prefixIconColor: Colors.white,
                borderColor: Colors.white,
                textColor: Colors.grey.withOpacity(0.8),
                hintColor: Colors.grey.withOpacity(0.8),
                borderRadius: 10),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: DropdownButton<String>(
              isExpanded: true,
              dropdownColor: backgroundBeige,
              value: dropdownValue,
              elevation: 16,
              style:
                  TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 18),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>[
                'Seç',
                'Anatomi',
                'Fizyoloji',
                'Genel Cerrahi',
                'Onkoloji',
                'Dermatoloji'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: DropdownButton<String>(
              isExpanded: true,
              dropdownColor: backgroundBeige,
              value: dropdownValue2,
              elevation: 16,
              style:
                  TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 18),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue2 = newValue!;
                });
              },
              items: listeProf.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          FormHelper.submitButton("Kayıt Ol", () {
            print("ben malım");
            if (widget.validate()) {
              widget.onSaved(false);
              DoctorRegisterRequest model = DoctorRegisterRequest(
                email: email!,
                password: password!,
                name: name!,
                surname: surname!,
                phone: phone,
                hospital: hospital!,
                school: school!,
                major: dropdownValue,
                profession: dropdownValue2,
              );
              APIService.doctorRegister(model).then((res) {
                if (res.success) {
                  widget.onSaved(true);
                  FormHelper.showSimpleAlertDialog(context, Config.appName,
                      "Kayıt Başarılı. Giriş Yapabilirsiniz", "Tamam", () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/userLogin', (route) => false);
                  });
                } else {
                  widget.onSaved(false);
                  FormHelper.showSimpleAlertDialog(
                      context, Config.appName, res.msg, "Tamam", () {
                    Navigator.pop(context);
                  });
                }
              });
            }
          },
              btnColor: newDarkRed,
              borderColor: newDarkRed,
              txtColor: Colors.white,
              borderRadius: 30),
          const SizedBox(
            height: 15,
          ),
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
      ),
    );
  }
}
