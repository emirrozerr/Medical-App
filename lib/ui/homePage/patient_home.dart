import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:tele_tip/app_colors.dart';
import 'package:tele_tip/config.dart';
import 'package:tele_tip/models/get_doctor_res.dart';
import 'package:tele_tip/services/api_service.dart';
import 'package:tele_tip/services/shared_service.dart';
import 'package:tele_tip/ui/messagePage/chat_details.dart';
import 'package:tele_tip/ui/widgets/greetings.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({Key? key}) : super(key: key);

  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class _PatientHomePageState extends State<PatientHomePage> {
  bool isAPIcallProcess = false;
  GlobalKey<FormState> globalFromKey = GlobalKey<FormState>();
  int type = 0;
  String doctorName = "";
  String dropdownValue = 'Seç';
  String dropdownValue2 = 'Seç';
  Future<String> name = APIService.getName();

  var listeProf = <String>[
    'Seç',
    'Bel Fıtığı',
    'Boyun Fıtığı',
    'Omurilik Felci',
    'Optik',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBeige,
      body: ProgressHUD(
        key: UniqueKey(),
        inAsyncCall: isAPIcallProcess,
        opacity: 0.3,
        child: Form(
          key: globalFromKey,
          child: SingleChildScrollView(child: _main(context)),
        ),
      ),
    );
  }

  Widget userName() {
    return FutureBuilder(
        future: SharedService.loginDetails(),
        builder: (BuildContext context, model) {
          if (model.hasData) {
            return Text(
              model.data!.user.name,
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: logoRed),
            );
          }

          return const Text("");
        });
  }

  Widget _main(context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.5,
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
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [greetings(), userName()],
              ),
            ),
            const SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Doktor Ara",
                  style: TextStyle(
                      color: newDarkRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Divider(
                  color: newDarkRed,
                  thickness: 1.5,
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: type != 0
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    type != 0
                        ? SizedBox(
                            height: 45,
                            width: 138,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      type = 0;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.backspace,
                                    color: logoRed,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Center(),
                  ],
                ),
              ],
            ),
            type == 0
                ? typeZero()
                : type == 1
                    ? typeOne()
                    : type == 2
                        ? typeTwo()
                        : typeThree()
          ],
        ),
      ),
    );
  }

  Widget typeZero() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          button(() {
            setState(() {
              type = 1;
            });
          }, "isme göre arama", Icons.search),
          SizedBox(
            height: size.height * 0.05,
          ),
          button(() {
            setState(() {
              type = 2;
            });
          }, "anabilim dalına göre arama", Icons.medical_services),
          SizedBox(
            height: size.height * 0.05,
          ),
          button(() {
            setState(() {
              type = 3;
            });
          }, "uzmanlık alanına göre arama", Icons.airline_seat_flat)
        ],
      ),
    );
  }

  Widget typeOne() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        FormHelper.inputFieldWidget(context, "Doctor", "Doktor Adı yazınız",
            (onValidateVal) {
          return null;
        }, (onSavedVal) {
          doctorName = onSavedVal;
        }, onChange: (val) {
          setState(() {
            doctorName = val;
          });
        },
            borderFocusColor: logoRed,
            borderColor: logoRed,
            textColor: newDarkRed,
            hintColor: logoRed.withOpacity(0.7),
            borderRadius: 10),
        doctorName != "" ? getDoctorbyName(doctorName) : const Center(),
      ],
    );
  }

  Widget typeTwo() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        DropdownButton<String>(
          dropdownColor: backgroundBeige,
          value: dropdownValue,
          elevation: 16,
          style: TextStyle(color: logoRed, fontSize: 18),
          underline: Container(
            height: 2,
            color: logoRed,
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
        dropdownValue != "Seç" ? getMajorListB(dropdownValue) : const Center(),
      ],
    );
  }

  Widget typeThree() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        DropdownButton<String>(
          dropdownColor: backgroundBeige,
          value: dropdownValue2,
          elevation: 16,
          style: TextStyle(color: logoRed, fontSize: 18),
          underline: Container(
            height: 2,
            color: logoRed,
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
        dropdownValue2 != "Seç"
            ? getMajorListA(dropdownValue2)
            : const Center(),
      ],
    );
  }

  Widget getMajorListA(dropdownValue) {
    return FutureBuilder(
        future: APIService.getDoctorA(dropdownValue),
        builder: (BuildContext ctx, AsyncSnapshot<GetDoctorRes> snapshot) =>
            snapshot.hasData
                ? Column(
                    children: [
                      SizedBox(
                        height: 500,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.body.length,
                            itemBuilder: (BuildContext context, index) =>
                                InkWell(
                                  child: Container(
                                      height: 450,
                                      width: 300,
                                      padding: const EdgeInsets.only(
                                          right: 30, left: 30, top: 45),
                                      margin: const EdgeInsets.only(
                                          right: 30, left: 30, top: 45),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(1, 9),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 200.0,
                                            width: 200.0,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 3.0,
                                                    color: newDarkRed),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      spreadRadius: 2,
                                                      blurRadius: 10,
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      offset:
                                                          const Offset(0, 10)),
                                                ],
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "http://${Config.apiURL}/uploads/${snapshot.data!.body[index].image}"))),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            ("${snapshot.data!.body[index].name} ${snapshot.data!.body[index].surname}")
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: newDarkRed),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 8, left: 10, top: 5),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          blurRadius: 1,
                                                          offset: const Offset(
                                                              1, 1),
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10)),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors.white)),
                                                  child: SizedBox(
                                                    width: 200,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          snapshot
                                                              .data!
                                                              .body[index]
                                                              .science,
                                                          style: TextStyle(
                                                              color: newDarkRed,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: newDarkRed),
                                            onPressed: () async {
                                              var a = "";
                                              var loginDetails =
                                                  await SharedService
                                                      .loginDetails();

                                              if (loginDetails!.user.id <
                                                  snapshot
                                                      .data!.body[index].id) {
                                                a = "${loginDetails.user.id}-${snapshot.data!.body[index].id}";
                                              } else {
                                                a = "${snapshot.data!.body[index].id}-${loginDetails.user.id}";
                                              }
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MessageDetails(
                                                          id: int.parse(
                                                              (loginDetails
                                                                      .user.id)
                                                                  .toString()),
                                                          target: int.parse(
                                                              (snapshot
                                                                  .data!
                                                                  .body[index]
                                                                  .id
                                                                  .toString())),
                                                          duo: a,
                                                          image:
                                                              "http://${Config.apiURL}/uploads/${snapshot.data!.body[index].image}",
                                                          userName:
                                                              ("${snapshot.data!.body[index].name} ${snapshot.data!.body[index].surname}")
                                                                  .toString()
                                                                  .toTitleCase(),
                                                        )),
                                              );
                                            },
                                            child: const Text(
                                              'Mesaj Gönder',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      )),
                                )),
                      ),
                    ],
                  )
                : const Center(
                    child: Text("Doktor Bulunamadı."),
                  ));
  }

  Widget getMajorListB(dropdownValue) {
    return FutureBuilder(
        future: APIService.getDoctorB(dropdownValue),
        builder: (BuildContext ctx, AsyncSnapshot<GetDoctorRes> snapshot) =>
            snapshot.hasData
                ? Column(
                    children: [
                      SizedBox(
                        height: 500,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.body.length,
                            itemBuilder: (BuildContext context, index) =>
                                InkWell(
                                  child: Container(
                                      height: 450,
                                      width: 300,
                                      padding: const EdgeInsets.only(
                                          right: 30, left: 30, top: 45),
                                      margin: const EdgeInsets.only(
                                          right: 30, left: 30, top: 45),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(1, 9),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 200.0,
                                            width: 200.0,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 3.0,
                                                    color: newDarkRed),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      spreadRadius: 2,
                                                      blurRadius: 10,
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      offset:
                                                          const Offset(0, 10)),
                                                ],
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "http://${Config.apiURL}/uploads/${snapshot.data!.body[index].image}"))),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            ("${snapshot.data!.body[index].name} ${snapshot.data!.body[index].surname}")
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: newDarkRed),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 8, left: 10, top: 5),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          blurRadius: 1,
                                                          offset: const Offset(
                                                              1, 1),
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10)),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors.white)),
                                                  child: SizedBox(
                                                    width: 200,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          snapshot
                                                              .data!
                                                              .body[index]
                                                              .science,
                                                          style: TextStyle(
                                                              color: newDarkRed,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: newDarkRed),
                                            onPressed: () async {
                                              var a = "";
                                              var loginDetails =
                                                  await SharedService
                                                      .loginDetails();

                                              if (loginDetails!.user.id <
                                                  snapshot
                                                      .data!.body[index].id) {
                                                a = "${loginDetails.user.id}-${snapshot.data!.body[index].id}";
                                              } else {
                                                a = "${snapshot.data!.body[index].id}-${loginDetails.user.id}";
                                              }
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MessageDetails(
                                                          id: int.parse(
                                                              (loginDetails
                                                                      .user.id)
                                                                  .toString()),
                                                          target: int.parse(
                                                              (snapshot
                                                                  .data!
                                                                  .body[index]
                                                                  .id
                                                                  .toString())),
                                                          duo: a,
                                                          image:
                                                              "http://${Config.apiURL}/uploads/${snapshot.data!.body[index].image}",
                                                          userName:
                                                              ("${snapshot.data!.body[index].name} ${snapshot.data!.body[index].surname}")
                                                                  .toString()
                                                                  .toTitleCase(),
                                                        )),
                                              );
                                            },
                                            child: const Text(
                                              'Mesaj Gönder',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      )),
                                )),
                      ),
                    ],
                  )
                : const Center(
                    child: Text("Doktor Bulunamadı."),
                  ));
  }

  Widget getDoctorbyName(String doctorName) {
    return FutureBuilder(
        future: APIService.getDoctorUsagedName(doctorName),
        builder: (BuildContext ctx, AsyncSnapshot<GetDoctorRes> snapshot) =>
            snapshot.hasData
                ? Column(
                    children: [
                      SizedBox(
                        height: 500,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.body.length,
                            itemBuilder: (BuildContext context, index) =>
                                InkWell(
                                  child: Container(
                                      height: 450,
                                      width: 300,
                                      padding: const EdgeInsets.only(
                                          right: 30, left: 30, top: 45),
                                      margin: const EdgeInsets.only(
                                          right: 30, left: 30, top: 45),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(1, 9),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 200.0,
                                            width: 200.0,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 3.0,
                                                    color: newDarkRed),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      spreadRadius: 2,
                                                      blurRadius: 10,
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      offset:
                                                          const Offset(0, 10)),
                                                ],
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "http://${Config.apiURL}/uploads/${snapshot.data!.body[index].image}"))),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            ("${snapshot.data!.body[index].name} ${snapshot.data!.body[index].surname}")
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: newDarkRed),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 8, left: 10, top: 5),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          blurRadius: 1,
                                                          offset: const Offset(
                                                              1, 1),
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10)),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors.white)),
                                                  child: SizedBox(
                                                    width: 200,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          snapshot
                                                              .data!
                                                              .body[index]
                                                              .science,
                                                          style: TextStyle(
                                                              color: newDarkRed,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: newDarkRed),
                                            onPressed: () async {
                                              var a = "";
                                              var loginDetails =
                                                  await SharedService
                                                      .loginDetails();

                                              if (loginDetails!.user.id <
                                                  snapshot
                                                      .data!.body[index].id) {
                                                a = "${loginDetails.user.id}-${snapshot.data!.body[index].id}";
                                              } else {
                                                a = "${snapshot.data!.body[index].id}-${loginDetails.user.id}";
                                              }
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MessageDetails(
                                                          id: int.parse(
                                                              (loginDetails
                                                                      .user.id)
                                                                  .toString()),
                                                          target: int.parse(
                                                              (snapshot
                                                                  .data!
                                                                  .body[index]
                                                                  .id
                                                                  .toString())),
                                                          duo: a,
                                                          image:
                                                              "http://${Config.apiURL}/uploads/${snapshot.data!.body[index].image}",
                                                          userName:
                                                              ("${snapshot.data!.body[index].name} ${snapshot.data!.body[index].surname}")
                                                                  .toString()
                                                                  .toTitleCase(),
                                                        )),
                                              );
                                            },
                                            child: const Text(
                                              'Mesaj Gönder',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      )),
                                )),
                      ),
                    ],
                  )
                : const Center(
                    child: Text("Doktor Bulunamadı."),
                  ));
  }

  Widget button(void Function() onTap, String text, IconData icon) {
    return InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: newDarkRed,
            borderRadius: const BorderRadius.all(Radius.circular(40)),
          ),
          margin: const EdgeInsets.all(25),
          height: 60,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: backgroundBeige,
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: newDarkRed,
                ),
              ),
              Text(
                text.toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: buttonText,
                ),
              ),
            ],
          ),
        ));
  }
}
