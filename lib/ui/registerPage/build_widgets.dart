import 'package:flutter/material.dart';
import 'package:tele_tip/ui/app_colors.dart';

Widget buildAd() => Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "Ad",
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
            return "Ad alanı boş olamaz.";
          }
          return null;
        },
        onChanged: null,
      ),
    );

Widget buildSoyad() => Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "Soyad",
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
            return "Soyad alanı boş olamaz.";
          }
          return null;
        },
        onChanged: null,
      ),
    );

Widget buildMail() => Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "E-Mail",
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
            return "E-Mail alanı boş olamaz.";
          }
          return null;
        },
        onChanged: null,
      ),
    );

Widget buildSifre() => Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "Şifre",
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
            return "Şifre alanı boş olamaz.";
          }
          return null;
        },
        onChanged: null,
      ),
    );

Widget buildAnaBilim() => Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "Anabilim Dalı",
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
            return "Anabilim dalı alanı boş olamaz.";
          }
          return null;
        },
        onChanged: null,
      ),
    );

Widget buildUzmanlik() => Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "Uzmanlık",
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
            return "Uzmanlık alanı boş olamaz.";
          }
          return null;
        },
        onChanged: null,
      ),
    );

Widget buildFakulte() => Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "Mezun Olunan Okul",
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
            return "Okul alanı boş olamaz.";
          }
          return null;
        },
        onChanged: null,
      ),
    );

Widget buildSubmit(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/login");
              },
              child: Text(
                "Girişe Dön",
                style:
                    TextStyle(color: buttonText, backgroundColor: newLogoRed),
              )),
          // ElevatedButton(
          //     style: ElevatedButton.styleFrom(backgroundColor: newLogoRed),
          //     onPressed: () {
          //       Navigator.pushNamed(context, "/login");
          //     },
          //     child: Text(
          //       "Girişe Dön",
          //       style: TextStyle(
          //         color: buttonText,
          //         backgroundColor: newLogoRed),
          //     )),
          // ElevatedButton(
          //     style: ElevatedButton.styleFrom(backgroundColor: newLogoRed),
          //     onPressed: () {},
          //     child: Text(
          //       "Kayıt Ol",
          //       style: TextStyle(
          //         color: buttonText,
          //       ),
          //     )),
        ],
      ),
    );
