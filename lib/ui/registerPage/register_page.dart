import 'package:flutter/material.dart';
import 'package:tele_tip/ui/app_colors.dart';
import 'package:tele_tip/ui/loginPage/login.dart';
import 'package:tele_tip/ui/registerPage/build_widgets.dart';

class RolePage extends StatefulWidget {
  const RolePage({Key? key}) : super(key: key);

  @override
  _RolePageState createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return MaterialApp(
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: newLogoBeige,
              body: RoleWidget(
                tabController: tabController,
              ),
            )));
  }
}

class RoleWidget extends StatelessWidget {
  const RoleWidget({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      logoWidget(context),
      const SizedBox(
        height: 50,
      ),
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
              color: newLogoRed, borderRadius: BorderRadius.circular(12)),
          child: TabBar(
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: newLogoPink.withOpacity(0.5)),
              controller: tabController,
              isScrollable: true,
              labelPadding: const EdgeInsets.symmetric(horizontal: 30),
              tabs: [
                Tab(
                    child: Text(
                  "Hasta",
                  style: TextStyle(
                      color: newLogoBrown, fontWeight: FontWeight.bold),
                )),
                Tab(
                    child: Text(
                  "Doktor",
                  style:
                      TextStyle(color: buttonText, fontWeight: FontWeight.bold),
                ))
              ]),
        ),
      ),
      const SizedBox(height: 25),
      Expanded(
          child: TabBarView(
        controller: tabController,
        children: [
          _patientRegister(context),
          _doctorRegister(context),
        ],
      ))
    ]);
  }
}

Widget _patientRegister(BuildContext context) {
  return Column(children: [
    buildAd(),
    buildSoyad(),
    buildMail(),
    buildSifre(),
    RawMaterialButton(
        onPressed: (() {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        }),
        fillColor: newLogoRed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Text(
          "Girişe Dön",
          style: TextStyle(color: buttonText, fontWeight: FontWeight.bold),
        ))
  ]);
}

Widget _doctorRegister(BuildContext context) {
  return Column(children: [
    buildAd(),
    buildSoyad(),
    buildMail(),
    buildSifre(),
    buildAnaBilim(),
    buildUzmanlik(),
    buildFakulte(),
    RawMaterialButton(
        onPressed: (() {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        }),
        fillColor: newLogoRed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Text(
          "Girişe Dön",
          style: TextStyle(color: buttonText, fontWeight: FontWeight.bold),
        ))
  ]);
}
