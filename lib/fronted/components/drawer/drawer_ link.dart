// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:ninenty_second_per_word_app/fronted/style/app_style.dart';

class DrawerLink extends StatelessWidget {
  const DrawerLink(
      {super.key,
      required this.linkName,
      required this.icon,});
  final String linkName;
  final IconData icon;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              child: Icon(
                icon,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                linkName,
                style: AppStyle.fontStyle.copyWith(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
