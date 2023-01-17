import 'package:flutter/material.dart';
import 'package:tele_tip/app_colors.dart';
import 'package:tele_tip/models/user_message_res.dart';
import 'package:tele_tip/services/api_service.dart';
import 'package:tele_tip/ui/messagePage/chat_details.dart';

import '../../config.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBeige,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 45,
                    child: Text(
                      'Mesaj Kutusu',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: newDarkRed,
                        letterSpacing: 1,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              getAllMessageforUser()
            ],
          ),
        ),
      ),
    );
  }

  Widget getAllMessageforUser() {
    return FutureBuilder(
        future: APIService.getAllMessageforUser(),
        builder: (BuildContext ctx, AsyncSnapshot<UserMessageRes> snapshot) =>
            snapshot.hasData
                ? Column(
                    children: [
                      SizedBox(
                        height: 600,
                        child: ListView.builder(
                            itemCount: snapshot.data!.body.length,
                            itemBuilder: (BuildContext context, index) =>
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MessageDetails(
                                                id: int.parse((snapshot
                                                    .data!.body[index].source
                                                    .toString())),
                                                target: int.parse((snapshot
                                                    .data!.body[index].target
                                                    .toString())),
                                                duo: snapshot
                                                    .data!.body[index].duo
                                                    .toString(),
                                                image:
                                                    "http://${Config.apiURL}/uploads/${snapshot.data!.body[index].image}",
                                                userName:
                                                    ("${snapshot.data!.body[index].name} ${snapshot.data!.body[index].surname}")
                                                        .toString()
                                                        .toTitleCase(),
                                              )),
                                    );
                                  },
                                  child: message(
                                      ("${snapshot.data!.body[index].name} ${snapshot.data!.body[index].surname}")
                                          .toString()
                                          .toTitleCase(),
                                      "http://${Config.apiURL}/uploads/${snapshot.data!.body[index].image}",
                                      snapshot.data!.body.length - 1 == index),
                                )),
                      ),
                    ],
                  )
                : const Center(
                    child: Text("Hiç mesajınız bulunmuyor."),
                  ));
  }

  Widget message(String name, String image, bool isLast) {
    return Column(
      children: [
        const SizedBox(
          height: 3,
        ),
        Container(
          height: 1,
          decoration: BoxDecoration(color: newDarkRed),
        ),
        Container(
          padding: const EdgeInsets.only(top: 15, left: 15, bottom: 15),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 9,
                  height: MediaQuery.of(context).size.width / 9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 20,
                  decoration: BoxDecoration(color: newDarkRed),
                ),
                SizedBox(
                  child: Column(
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: newDarkRed,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                    ],
                  ),
                )
              ]),
        ),
        isLast
            ? Container(
                height: 1,
                decoration: BoxDecoration(color: newDarkRed),
              )
            : Container(),
      ],
    );
  }
}
