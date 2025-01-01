import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:ninenty_second_per_word_app/fronted/style/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:ninenty_second_per_word_app/database/DeckModel.dart';
import 'package:ninenty_second_per_word_app/database/hive_box.dart';
import 'package:ninenty_second_per_word_app/provider/schedule_provider.dart';

class FlipCardPage extends StatefulWidget {
  final int deckIndex;

  const FlipCardPage({
    super.key,
    required this.deckIndex,
  });

  @override
  _FlipCardPageState createState() => _FlipCardPageState();
}

class _FlipCardPageState extends State<FlipCardPage>
    with SingleTickerProviderStateMixin {
  late DeckModel selectedDeck;
  int currentIndex = 0;
  void showCustomDialog({
    //! costom dialog
    required BuildContext context,
    required String title,
    required String description,
    required String confirmText,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: const Color.fromARGB(255, 34, 34, 34),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orangeAccent,
                  size: 50,
                ),
                const SizedBox(height: 15),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.greenColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        onConfirm();
                        Navigator.pop(context);
                      },
                      child: Text(
                        confirmText,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Poppins'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    var deckBox = HiveBox.deck;
    selectedDeck = deckBox.getAt(widget.deckIndex)!;
  }

  void nextCard() {
    setState(() {
      if (currentIndex < selectedDeck.card.length - 1) {
        currentIndex++;
      } else {
        //! finish
        final provider = Provider.of<ScheduleProvider>(context, listen: false);
       

        // Показ завершения и выход
        showCustomDialog(
          context: context,
          title: 'Congratulations',
          description: 'You have revised all card of this deck',
          confirmText: 'Ok',
          onConfirm: () {
             provider.markDeckAsShown(widget.deckIndex);
            Navigator.pop(context);
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final card = selectedDeck.card[currentIndex];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 27, 27),
      appBar: AppBar(
          iconTheme:
              IconThemeData(color: const Color.fromARGB(255, 174, 174, 174)),
          centerTitle: true,
          title: _SpecialText(fontSize: 30, text: selectedDeck.name),
          backgroundColor: const Color.fromARGB(255, 27, 27, 27)),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (currentIndex + 1) / selectedDeck.card.length,
            backgroundColor: Colors.indigo[100],
            color: const Color.fromARGB(191, 65, 38, 118),
          ),
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
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: nextCard,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  currentIndex < selectedDeck.card.length - 1
                      ? 'Next'
                      : 'Finish',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Color.fromARGB(255, 204, 204, 204)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
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
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: const Offset(0, 4),
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
