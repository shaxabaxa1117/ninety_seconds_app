

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:ninenty_second_per_word_app/database/CardModel.dart';

class CardCheck extends StatelessWidget {
  final CardModel card;
  const CardCheck({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 27, 27),
      appBar: AppBar(
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 174, 174, 174)),
        centerTitle: true,
        title: _SpecialText(fontSize: 30, text: 'Chosen card'),
        backgroundColor: const Color.fromARGB(255, 27, 27, 27)
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: FlipCard(
                front: buildCard(
                  text: card.cardText ?? '',
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                back: buildCard(
                  text: card.cardSubText ?? '',
                  gradient: const LinearGradient(
                    colors: [Colors.orange, Colors.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
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




  Widget buildCard({required String text, required Gradient gradient}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 20,
      shadowColor: Colors.black87,
      child: Container(
        width: 400, // Увеличенный размер
        height: 500, // Увеличенный размер
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: gradient,
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28, // Увеличенный размер шрифта
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black45,
                    offset: Offset(0, 3),
     
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );


    
  }


class _SpecialText extends StatelessWidget {
  final double fontSize;
  final String text;
  const _SpecialText({super.key, required this.fontSize, required this.text});

  @override
  Widget build(BuildContext context) {
    return  RichText(
      text: TextSpan(
        children: [

          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Transform.translate(
              offset: const Offset(-4, -4.5), // Подкорректировал смещение текста
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 23, 59, 125),
                    Color.fromARGB(230, 37, 70, 130),
                    Color.fromARGB(246, 48, 37, 123),
                    Color.fromARGB(166, 78, 20, 129),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child:  Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: fontSize,
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