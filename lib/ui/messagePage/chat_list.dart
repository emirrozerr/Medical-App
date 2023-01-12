import 'package:flutter/material.dart';
import 'package:tele_tip/ui/app_colors.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

List<Map<String, String>> chatRoom = [
  {
    "name": "Kişi 1",
    "image": "https://genshin.honeyhunterworld.com/img/kazuha_047.webp",
  },
  {
    "name": "Kişi 2",
    "image": "https://genshin.honeyhunterworld.com/img/shenhe_063.webp"
  }
];

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: newBeige,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Mesaj Kutusu",
              style: TextStyle(color: newDarkRed),
            ),
            centerTitle: true,
            backgroundColor: newBeige),
        body: Chatroom(chatRoom: chatRoom));
  }
}

class Chatroom extends StatelessWidget {
  final List<Map<String, String>> chatRoom;
  const Chatroom({
    Key? key,
    required this.chatRoom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: chatRoom.length,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/detailedMsg');
              },
              leading: Image.network(chatRoom[index]["image"]!),
              title: Text(chatRoom[index]["name"]!),
            ),
          );
        }));
  }
}
