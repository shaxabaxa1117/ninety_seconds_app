import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ninenty_second_per_word_app/database/CardModel.dart';
import 'package:ninenty_second_per_word_app/database/hive_box.dart';
import 'package:ninenty_second_per_word_app/fronted/pages/main_pages/card_check.dart';
import 'package:ninenty_second_per_word_app/fronted/style/app_colors.dart';
import 'package:ninenty_second_per_word_app/provider/deck_provider.dart';
import 'package:provider/provider.dart';

class FavouriteWordsPage extends StatefulWidget {
  const FavouriteWordsPage({super.key});

  @override
  State<FavouriteWordsPage> createState() => _FavouriteWordsPageState();
}

class _FavouriteWordsPageState extends State<FavouriteWordsPage> {
  @override
  Widget build(BuildContext context) {
    var modelDeck = context.watch<DeckProvider>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor, // Цвет фона
      body: ValueListenableBuilder(
        valueListenable: HiveBox.favCards.listenable(),
        builder: (context, Box<CardModel> favCards, _) {
          var allCards = favCards.values.toList();

          if (allCards.isEmpty) {
            return const Center(
              child: Text(
                'No favourite cards available',
                style: TextStyle(
                    color: Color.fromARGB(157, 243, 243, 243), fontSize: 18),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (context, index) {
              final card = allCards[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CardCheck(card: card),
                      )),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: const [
                          Color.fromRGBO(177, 71, 47, 1),
                          Color.fromRGBO(183, 94, 30, 1),
                          Color.fromRGBO(113, 32, 145, 0.78)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Text(
                        card.cardText.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.red),
                        onPressed: () async {
                          // Удаляем карту из избранного
                          await modelDeck.removeFromFavourites(card);

                          // Показываем SnackBar с возможностью отменить удаление
                          // ignore: use_build_context_synchronously
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Card removed from favourites',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.grey[800],
                                action: SnackBarAction(
                                  label: 'UNDO',
                                  textColor: Colors.orange,
                                  onPressed: () async {
                                    // Возвращаем карту в избранное
                                    await modelDeck.addToFavourites(card);
                                  },
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: allCards.length,
          );
        },
      ),
    );
  }
}
