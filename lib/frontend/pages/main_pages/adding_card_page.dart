import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:ninenty_second_per_word_app/database/CardModel.dart';
import 'package:ninenty_second_per_word_app/frontend/components/others/alert_to_fill_dialog.dart';
import 'package:ninenty_second_per_word_app/frontend/components/others/new_card_texts.dart';
import 'package:ninenty_second_per_word_app/frontend/components/sentence_text_field.dart';
import 'package:ninenty_second_per_word_app/frontend/components/word_text_field.dart';
import 'package:ninenty_second_per_word_app/frontend/style/app_colors.dart';

import 'package:ninenty_second_per_word_app/provider/deck_provider.dart';

import 'package:provider/provider.dart';

class AddingCardPage extends StatelessWidget {
  final int index;
  const AddingCardPage({
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final modelDeck = context.watch<DeckProvider>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
        child: Stack(
          children: [
            Row(
              children: [
                Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.cancel, size: 35),
                  color: const Color.fromARGB(204, 82, 89, 95),
                ),
              ],
            ),
            Column(
              children: [
                CardText(word: 'Adding '),
                SizedBox(
                  height: 30,
                ),
                WordTextField(wordController: modelDeck.cardText),
                SizedBox(
                  height: 10,
                ),
                SentenceTextField(sentenceController: modelDeck.cardSubText),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: const Color.fromARGB(189, 255, 255, 255),
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        if (modelDeck.cardText.text == "" ||
                            modelDeck.cardSubText.text == "") {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CustomFillAlertDialog();
                            },
                          );
                        } else {
                          modelDeck.addCard(index); //! добавление карты
                        }
                      },
                      child: Text(
                        'Add card',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
