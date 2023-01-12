import 'package:flutter/material.dart';
import 'package:tele_tip/ui/app_colors.dart';
import 'package:tele_tip/ui/loginPage/login.dart';
import 'package:tele_tip/ui/widgets/custom_text_input.dart';

class RolePage extends StatefulWidget {
  const RolePage({Key? key}) : super(key: key);

  @override
  _RolePageState createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(vsync: this, length: 2);
    return Scaffold(
        backgroundColor: newBeige,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              logoWidget(context),
              const SizedBox(height: 25),
              Center(child: tabCard(tabController: tabController)),
              SizedBox(
                height: 600,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    _patientRegister(context),
                    _doctorRegister(context)
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

Widget _patientRegister(BuildContext context) {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final mailController = TextEditingController();
  final passwordController = TextEditingController();

  return Column(children: [
    CustomInput(
      errorText: "Ad boş olamaz",
      hintText: "Ad",
      controller: nameController,
    ),
    CustomInput(
      errorText: "Soyad boş olamaz",
      hintText: "Soyad",
      controller: surnameController,
    ),
    CustomInput(
      errorText: "E-Mail boş olamaz",
      hintText: "E-Mail",
      controller: mailController,
    ),
    CustomInput(
      errorText: "Şifre boş olamaz",
      hintText: "Şifre",
      controller: passwordController,
    ),
    const SizedBox(height: 15),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RawMaterialButton(
            onPressed: (() {
              Navigator.pushNamed(context, '/login');
            }),
            fillColor: logoRed,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text(
              "Girişe Dön",
              style: TextStyle(color: buttonText, fontWeight: FontWeight.bold),
            )),
        RawMaterialButton(
            onPressed: (() {}),
            fillColor: logoRed,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text(
              "Kayıt Ol",
              style: TextStyle(color: buttonText, fontWeight: FontWeight.bold),
            )),
      ],
    )
  ]);
}

Widget _doctorRegister(BuildContext context) {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final majorController = TextEditingController();
  final proController = TextEditingController();
  final collegeController = TextEditingController();

  return Column(children: [
    CustomInput(
      errorText: "Ad boş olamaz",
      hintText: "Ad",
      controller: nameController,
    ),
    CustomInput(
      errorText: "Soyad boş olamaz",
      hintText: "Soyad",
      controller: surnameController,
    ),
    CustomInput(
      errorText: "E-Mail boş olamaz",
      hintText: "E-Mail",
      controller: mailController,
    ),
    CustomInput(
      errorText: "Şifre boş olamaz",
      hintText: "Şifre",
      controller: passwordController,
    ),
    CustomInput(
      errorText: "Ana bilim alanı boş olamaz",
      hintText: "Ana Bilim Dalı",
      controller: majorController,
    ),
    CustomInput(
      errorText: "Uzmanlık alanı boş olamaz",
      hintText: "Uzmanlık",
      controller: proController,
    ),
    CustomInput(
      errorText: "Okul adı boş olamaz",
      hintText: "Mezun Olunan Okul",
      controller: collegeController,
    ),
    const SizedBox(height: 15),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RawMaterialButton(
            onPressed: (() {
              Navigator.pushNamed(context, '/login');
            }),
            fillColor: logoRed,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text(
              "Girişe Dön",
              style: TextStyle(color: buttonText, fontWeight: FontWeight.bold),
            )),
        RawMaterialButton(
            onPressed: (() {}),
            fillColor: logoRed,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text(
              "Kayıt Ol",
              style: TextStyle(color: buttonText, fontWeight: FontWeight.bold),
            )),
      ],
    )
  ]);
}

class tabCard extends StatelessWidget {
  const tabCard({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
            color: logoRed, borderRadius: BorderRadius.circular(12)),
        child: TabBar(
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: newDarkRed.withOpacity(0.5)),
            controller: tabController,
            isScrollable: true,
            labelPadding: const EdgeInsets.symmetric(horizontal: 30),
            tabs: [
              Tab(
                  child: Text(
                "Hasta",
                style:
                    TextStyle(color: newDarkRed, fontWeight: FontWeight.bold),
              )),
              Tab(
                  child: Text(
                "Doktor",
                style:
                    TextStyle(color: buttonText, fontWeight: FontWeight.bold),
              ))
            ]),
      ),
    );
  }
}
