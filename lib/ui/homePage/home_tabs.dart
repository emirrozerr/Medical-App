import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:tele_tip/app_colors.dart';
import 'package:tele_tip/ui/homePage/patient_home.dart';
import 'package:tele_tip/ui/messagePage/chat_list.dart';
import 'package:tele_tip/ui/profilePage/profile_page.dart';

class HomePage extends StatefulWidget {
  final int? index;
  const HomePage({super.key, this.index});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    setState(() {
      _selectedIndex = widget.index ?? 0;
    });
    super.initState();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    PatientHomePage(),
    MessagePage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.flip,
        backgroundColor: newDarkRed,
        color: Colors.white,
        items: const [
          TabItem(icon: Icons.home, title: "Anasayfa"),
          TabItem(icon: Icons.mail, title: "Mesajlar"),
          TabItem(icon: Icons.person, title: "Profil"),
        ],
        initialActiveIndex: _selectedIndex != 5 ? _selectedIndex : 4,
        onTap: ((int i) => _onItemTapped(i)),
      ),
    );
  }
}
