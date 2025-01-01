import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ninenty_second_per_word_app/database/DeckModel.dart';
import 'package:ninenty_second_per_word_app/database/hive_box.dart';
import 'package:ninenty_second_per_word_app/frontend/components/others/new_card_texts.dart';
import 'package:ninenty_second_per_word_app/frontend/pages/main_pages/adding_card_page.dart';
import 'package:ninenty_second_per_word_app/frontend/pages/main_pages/edit_note_page.dart';
import 'package:ninenty_second_per_word_app/frontend/style/app_colors.dart';
import 'package:ninenty_second_per_word_app/provider/deck_provider.dart';
import 'package:provider/provider.dart';

class CardList extends StatelessWidget {
  final int deckIndex;
  const CardList({super.key, required this.deckIndex});

  @override
  Widget build(BuildContext context) {
    var choosenDeck = HiveBox.deck.values.toList();
    final modelDeck = context.watch<DeckProvider>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CardText(
                    word: "${choosenDeck[deckIndex].name.toUpperCase()} 's ",
                    isNotPlurar: false,
                  ),
                ),
              ),
              choosenDeck[deckIndex].card.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.dangerous_outlined,
                              size: 55,
                              color: Color.fromARGB(157, 243, 243, 243),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'You have no card in this deck',
                              style: TextStyle(
                                color: Color.fromARGB(157, 243, 243, 243),
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 30),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                width: 250,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: const [
                                      Color.fromARGB(255, 23, 59, 125),
                                      Color.fromARGB(230, 37, 70, 130),
                                      Color.fromARGB(246, 48, 37, 123),
                                      Color.fromARGB(166, 78, 20, 129)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AddingCardPage(index: deckIndex),
                                    ),
                                  ),
                                  child: Text(
                                    'Create the first card',
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 190, 190, 190),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 130,
                            )
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: HiveBox.deck.listenable(),
                        builder: (context, Box<DeckModel> deck, _) {
                          final decks = deck.values.toList();
                          return ListView.separated(
                            padding: const EdgeInsets.all(8.0),
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: Container(
                                  height: 90,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: const [
                                        Color.fromARGB(255, 23, 59, 125),
                                        Color.fromARGB(230, 37, 70, 130),
                                        Color.fromARGB(246, 48, 37, 123),
                                        Color.fromARGB(166, 78, 20, 129)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Center(
                                    child: ListTile(
                                      title: Text(
                                        decks[deckIndex]
                                            .card[index]
                                            .cardText //! назвние карты
                                            .toString(),
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                249, 196, 196, 196),
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Text(
                                        decks[deckIndex]
                                            .card[index]
                                            .cardSubText
                                            .toString(),
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                215, 194, 194, 194),
                                            fontFamily: 'Poppins',
                                            fontSize: 16),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      trailing: SizedBox(
                                        width: 144,
                                        child: Row(
                                          children: [
                                            !choosenDeck[deckIndex].isStarted &&
                                                    !choosenDeck[deckIndex]
                                                        .isLearned
                                                ? IconButton(
                                                    onPressed: () {
                                                      modelDeck
                                                          .prepareTextFields(
                                                        deckIndex: deckIndex,
                                                        cardIndex: index,
                                                      );
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditCardPage(
                                                            deckIndex:
                                                                deckIndex,
                                                            cardIndex: index,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      Icons.edit,
                                                      color: Color.fromARGB(
                                                          157, 255, 255, 255),
                                                    ),
                                                  )
                                                : const SizedBox(
                                                    width: 20,
                                                  ),
                                            IconButton(
                                              onPressed: () {
                                                modelDeck.deleteCard(
                                                    deckIndex: deckIndex,
                                                    cardIndex: index);
                                              },
                                              icon: Icon(Icons.delete,
                                                  color: const Color.fromARGB(
                                                      157, 255, 255, 255)),
                                            ),
                                             !choosenDeck[deckIndex].card[index].isFavourite! ? 
                                            IconButton(
                                                onPressed: () {
                                                modelDeck.setFavourite(deckIndex: deckIndex, cardIndex: index);
                                                modelDeck.updateFavouritrCard();
                                                print('Is favourite: ${decks[deckIndex].card[index].isFavourite}');
                                                },
                                                icon: Icon(
                                                  Icons.favorite_border,
                                                  color: Color.fromARGB(
                                                      157, 255, 255, 255),
                                                )) : 
                                                IconButton(
                                                onPressed: () {
                                                modelDeck.setFavourite(deckIndex: deckIndex, cardIndex: index);
                                                modelDeck.updateFavouritrCard();
                                                print('Is favourite: ${decks[deckIndex].card[index].isFavourite}');
                                                },
                                                icon: Icon(
                                                  Icons.favorite,
                                                  color: Color.fromARGB(
                                                      157, 255, 255, 255),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10),
                            itemCount: decks[deckIndex].card.length,
                          );
                        },
                      ),
                    ),
            ],
          ),
          Row(
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 54, right: 5),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.cancel, size: 35),
                  color: const Color.fromARGB(204, 82, 89, 95),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
