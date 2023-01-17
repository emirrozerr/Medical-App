import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tele_tip/app_colors.dart';
import 'package:tele_tip/config.dart';
import 'package:tele_tip/services/api_service.dart';
import 'package:tele_tip/services/shared_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isUpdate = false;
  XFile? imageFile;
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Lütfen Seçiniz",
              style: TextStyle(color: newDarkRed),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: newDarkRed,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: const Text("Galeri"),
                    leading: Icon(
                      Icons.account_box,
                      color: newDarkRed,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: newDarkRed,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: const Text("Kamera"),
                    leading: Icon(
                      Icons.camera,
                      color: newDarkRed,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  List<String> list = [
    'bla',
    'Anatomi',
    'Fizyoloji',
    'Genel Cerrahi',
    'Onkoloji',
    'Dermatoloji'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBeige,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
                      child: !isUpdate ? userImage() : updateImage()),
                  const SizedBox(
                    height: 15,
                  ),
                  userName()
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            FutureBuilder(
              future: SharedService.loginDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "E-Mail: ",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: newDarkRed),
                            ),
                            Text(
                              snapshot.data!.user.email,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Telefon: ",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: newDarkRed),
                            ),
                            Text(
                              snapshot.data!.user.phone,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        if (snapshot.data!.user.isDoctor == 1)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Ana Bilim Dalı: ",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: newDarkRed),
                              ),
                              Text(
                                list[snapshot.data!.user.major!],
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Uzmanlık Alanları: ",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: newDarkRed),
                            ),
                            Text(
                              snapshot.data!.user.profession!,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "İlişikli Hastane: ",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: newDarkRed),
                            ),
                            Text(
                              snapshot.data!.user.hospital!,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Mezun Olunan Okul: ",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: newDarkRed),
                            ),
                            Text(
                              snapshot.data!.user.school!,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                  child: ElevatedButton(
                onPressed: () {
                  SharedService.logout(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: newDarkRed,
                ),
                child: const Text(
                  "Çıkış yap",
                  style: TextStyle(color: Colors.white),
                ),
              )),
            ),
          ],
        )),
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = image!;
      isUpdate = true;
    });

    await APIService.userImageUpdate(image!);

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = photo!;
      isUpdate = true;
    });

    await APIService.userImageUpdate(photo!);

    // print("Image:${imageFile!.path}");
    Navigator.pop(context);
  }

  Widget updateImage() {
    return Stack(
      children: [
        Container(
          height: 120.0,
          width: 120.0,
          decoration: BoxDecoration(
              border: Border.all(width: 5.0, color: Colors.white),
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 10)),
              ],
              image: DecorationImage(
                  fit: BoxFit.cover, image: FileImage(File(imageFile!.path)))),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    border: Border.all(width: 4, color: Colors.white),
                    color: Colors.blue,
                    shape: BoxShape.circle),
                child: IconButton(
                  iconSize: 15,
                  onPressed: () {
                    _showChoiceDialog(context);
                  },
                  icon: const Icon(
                    Icons.edit_sharp,
                    color: Colors.white,
                  ),
                )))
      ],
    );
  }

  Widget userImage() {
    return FutureBuilder(
        future: APIService.getImage(),
        builder: (BuildContext context, AsyncSnapshot<String> model) {
          if (model.hasData) {
            return Stack(
              children: [
                Container(
                  height: 120.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                      border: Border.all(width: 5.0, color: Colors.white),
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10)),
                      ],
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "http://${Config.apiURL}/uploads/${model.data!}"))),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            color: Colors.blue,
                            shape: BoxShape.circle),
                        child: IconButton(
                          iconSize: 15,
                          onPressed: () {
                            _showChoiceDialog(context);
                          },
                          icon: const Icon(
                            Icons.edit_sharp,
                            color: Colors.white,
                          ),
                        )))
              ],
            );
          }

          return const Text("");
        });
  }

  Widget userProfile() {
    return FutureBuilder(
        future: APIService.getEmail(),
        builder: (BuildContext context, AsyncSnapshot<String> model) {
          if (model.hasData) {
            return Center(
              child: Text(
                model.data!,
              ),
            );
          }

          return const Text("");
        });
  }

  Widget userName() {
    return FutureBuilder(
        future: APIService.getName(),
        builder: (BuildContext context, AsyncSnapshot<String> model) {
          if (model.hasData) {
            return Text(
              model.data!.toUpperCase(),
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: newDarkRed),
            );
          }

          return const Text("");
        });
  }
}
