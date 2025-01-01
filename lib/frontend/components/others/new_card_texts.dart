import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardText extends StatelessWidget {
  CardText({super.key, required this.word, this.isNotPlurar = true});
  String? word;
  bool isNotPlurar;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: word,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: const Color.fromARGB(255, 207, 206, 206),
              fontSize: 28.4,
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Transform.translate(
              offset: const Offset(
                  0, -6), // Adjust the offset to move "card" higher
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                                  const Color.fromARGB(255, 23, 59, 125),
                                Color.fromARGB(230, 37, 70, 130),
                                Color.fromARGB(246, 48, 37, 123),
                                   Color.fromARGB(166, 78, 20, 129)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child:  Text(
                  isNotPlurar == true ? 'card' : 'cards',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
