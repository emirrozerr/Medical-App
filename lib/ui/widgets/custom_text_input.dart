import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String errorText;
  final String hintText;
  final TextEditingController controller;

  const CustomInput(
      {super.key,
      required this.errorText,
      required this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Colors.white,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white))),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorText;
          }
          return null;
        },
        controller: controller,
      ),
    );
  }
}
