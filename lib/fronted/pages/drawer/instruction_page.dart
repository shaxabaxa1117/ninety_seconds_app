import 'package:flutter/material.dart';
import 'package:ninenty_second_per_word_app/fronted/style/app_colors.dart';

class InstructionPage extends StatelessWidget {
  const InstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: _SpecialText(fontSize: 30, text: 'Instruction'),
        iconTheme: IconThemeData(color: Colors.grey),
        elevation: 0,
      ),
      body: Container(
        color: AppColors.backgroundColor,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                'The 90-Second Method for Memorization',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                ),
              ),
              const SizedBox(height: 20),
              // Main text
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(
                      text: 'This application implements the idea of the method \n\n ',
                      style: TextStyle(color: Color.fromARGB(255, 43, 65, 194),fontSize: 20,fontFamily: 'Poppins',fontWeight: FontWeight.w600)
                    ),
                    TextSpan(
                      text:
                          'Imagine a farmer, Cornelius, who bought expensive seeds of beautiful Dutch tomatoes. ',
                    ),
                    TextSpan(
                      text:
                          'When grown, they become yellow-orange and taste amazing. It usually takes three months from planting to harvest. ',
                    ),
                    TextSpan(
                      text:
                          'Cornelius planted these valuable seeds and started watering them. Two months passed...',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    TextSpan(
                      text:
                          '\n\nAnd suddenly, Farmer Cornelius lost interest in his tomatoes. He stopped watering them. What do you think happened next? ',
                    ),
                    TextSpan(
                      text: '\n\nIt’s easy to guess: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    TextSpan(
                      text:
                          'very soon, all the plants withered, and Cornelius never got to enjoy any delicious yellow-orange tomatoes. ',
                    ),
                    TextSpan(
                      text: '\n\nNow, what about learning foreign languages?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.redAccent,
                      ),
                    ),
                    TextSpan(
                      text:
                          '\n\nThe thing is, our memory has an interesting feature...',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.white),
              const SizedBox(height: 20),
              // Subheading
              const Text(
                'How does it work?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '1) Record words in context.\n'
                '2) Encounter phrases 7-9 times.\n'
                '3) Use them in speech.\n\n'
                'Remember, repetitions should be precise, and every encounter with a phrase should be meaningful.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              // Subheading
              const Text(
                'The Key Points:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '• Our memory retains information that we encounter 7-9 times in various contexts.\n'
                '• Words should be recorded in context, not as isolated translations.\n'
                '• Easy words may require fewer repetitions, while harder ones might need more focus and emotion.\n'
                '• The learned vocabulary must be used in live conversations, or it will be forgotten.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              // Button to go back
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: const [
                        Color.fromARGB(255, 23, 59, 125),
                        Color.fromARGB(230, 37, 70, 130),
                        Color.fromARGB(246, 48, 37, 123),
                        Color.fromARGB(166, 78, 20, 129),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
                    child: TextButton(

                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpecialText extends StatelessWidget {
  final double fontSize;
  final String text;
  const _SpecialText({super.key, required this.fontSize, required this.text});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Transform.translate(
              offset:
                  const Offset(-4, -4.5), // Подкорректировал смещение текста
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
                child: Text(
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
