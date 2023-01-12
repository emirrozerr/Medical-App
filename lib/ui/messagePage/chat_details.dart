import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tele_tip/ui/app_colors.dart';
import 'package:tele_tip/ui/models/message_models.dart';

final data = jsonDecode(
    '{"id": 1,"name": "Kişi 1","image": "https://genshin.honeyhunterworld.com/img/kazuha_047.webp","messages": [ {"mID": 12, "mDetail": "sdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdf", "senderID": 1},{"mID": 13, "mDetail": "mrb", "senderID": 2}]}');

final models = MessageModel.fromJson(data);

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({super.key});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final _controller = TextEditingController();
  String? message;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: newBeige,
      body: SafeArea(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/home');
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: newDarkRed,
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: 45.0,
                                height: 45.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: DecorationImage(
                                    image: NetworkImage(models.image!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                models.name!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: newDarkRed,
                                  letterSpacing: 0.8,
                                  height: 1.25,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const SizedBox(width: 30),
                        ],
                      ),
                    ),
                    Divider(
                      color: newDarkRed,
                    ),
                  ],
                ),
              ),
              allMessages(screenHeight - 220, keyboardHeight),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onChanged: (onSavedVal) {
                          message = onSavedVal;
                        },
                        style: TextStyle(
                          fontSize: 14.0,
                          color: newDarkRed,
                          letterSpacing: 0.7000000000000001,
                          fontWeight: FontWeight.w600,
                          height: 1.43,
                        ),
                        cursorColor: newDarkRed,
                        decoration: InputDecoration(
                          hintText: 'Mesaj gönder',
                          hintStyle: TextStyle(
                            color: buttonText,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: newBeige,
                            backgroundColor: newDarkRed),
                        onPressed: () async {},
                        child: Row(
                          children: const [Icon(Icons.send)],
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget allMessages(screen, keyboard) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: screen - (keyboard + 56),
      child: ListView.builder(
          itemCount: models.messages!.length,
          itemBuilder: ((context, index) => Padding(
              padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
              child: models.id == models.messages![index]!.senderID!
                  ? source(models.messages![index]!.mDetail!)
                  : target(models.messages![index]!.mDetail!)))),
    );
  }

  Widget source(String text) {
    return Container(
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.40,
          top: 5,
          right: 5,
          bottom: 5),
      padding: const EdgeInsets.all(19),
      width: 250,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
        ),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: const Alignment(0.97, -1.0),
          colors: [newOrange, newDarkRed],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: const Offset(0, 5.0),
            blurRadius: 14.0,
          ),
        ],
      ),
      child: Text(
        textAlign: TextAlign.right,
        text,
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.white,
          letterSpacing: 0.7000000000000001,
          fontWeight: FontWeight.w600,
          height: 1.43,
        ),
      ),
    );
  }

  Widget target(String text) {
    return Container(
      margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.40,
          top: 5,
          left: 5,
          bottom: 5),
      padding: const EdgeInsets.all(19),
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: const Alignment(0.97, -1.0),
          colors: [newDarkRed, newOrange],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            offset: const Offset(0, 7.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14.0,
            color: Color(0xFFECF1FF),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
