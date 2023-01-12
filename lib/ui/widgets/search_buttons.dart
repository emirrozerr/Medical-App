import 'package:flutter/material.dart';
import 'package:tele_tip/ui/app_colors.dart';

class CustomSeachButton extends StatelessWidget {
  final String text;
  final IconData icon;
  const CustomSeachButton({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: (() {}),
      fillColor: newDarkRed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
