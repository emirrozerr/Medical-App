import 'package:flutter/material.dart';
import 'package:tele_tip/ui/app_colors.dart';
import 'package:tele_tip/ui/widgets/greetings.dart';
import 'package:tele_tip/ui/widgets/search_buttons.dart';

class DoctorSearch extends StatefulWidget {
  const DoctorSearch({super.key});

  @override
  State<DoctorSearch> createState() => _DoctorSearchState();
}

class _DoctorSearchState extends State<DoctorSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: newBeige,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              shortLogo(context),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Greetings(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "İsim",
                          style: TextStyle(
                              fontSize: 35,
                              color: logoRed,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Doktor Ara   ",
                          style: TextStyle(
                              color: newDarkRed,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Divider(
                          color: newDarkRed,
                          thickness: 1.5,
                        ),
                        Column(
                          children: [
                            const CustomSeachButton(
                                text: "İsme Göre Arama",
                                icon: Icons.person_search_outlined),
                            const CustomSeachButton(
                                text: "Uzmanlığa Göre Arama",
                                icon: Icons.assignment_ind_outlined),
                            const CustomSeachButton(
                                text: "Ana Bilim Dalına Göre Arama",
                                icon: Icons.apartment_outlined),
                            RawMaterialButton(
                              onPressed: (() {
                                Navigator.pushNamed(context, '/login');
                              }),
                              fillColor: newDarkRed,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Text(
                                "Çıkış Yap",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget shortLogo(BuildContext context) {
  return Container(
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
            width: 125,
            fit: BoxFit.contain,
          ),
        )
      ],
    ),
  );
}
