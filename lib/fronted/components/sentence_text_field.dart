import 'package:flutter/material.dart';

class SentenceTextField extends StatelessWidget {
  SentenceTextField({super.key, required this.sentenceController});

  final TextEditingController sentenceController;

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
            controller: sentenceController,
            maxLines: 7, // Ограничение на 7 строк
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: Colors.blueAccent,
                  width: 2.0,
                ),
              ),
              labelText: 'Enter your sentence(s)',
              labelStyle: TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
              alignLabelWithHint: true,
              contentPadding: const EdgeInsets.only(left: 16, top: 16, bottom: 7, right: 16),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
