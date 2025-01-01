// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';

class WordTextField extends StatelessWidget {
  
  WordTextField({super.key,required this.wordController});
  final TextEditingController wordController;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: TextField(
            style: TextStyle(color: Colors.white),
            controller: wordController,
            maxLines: 1,
            decoration: InputDecoration(
              
              hintText: 'Enter a word or phrase',
              hintStyle: TextStyle(color: Colors.grey[500]),
              prefixIcon: Icon(Icons.text_fields, color: Colors.grey[500]),
              filled: true,
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Colors.blueAccent,
                width: 2.0,
              ),
            ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            ),
            
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
