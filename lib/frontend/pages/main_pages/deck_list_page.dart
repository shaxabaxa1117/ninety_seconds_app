import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ninenty_second_per_word_app/database/DeckModel.dart';
import 'package:ninenty_second_per_word_app/database/hive_box.dart';
import 'package:ninenty_second_per_word_app/frontend/pages/main_pages/adding_card_page.dart';
import 'package:ninenty_second_per_word_app/frontend/pages/main_pages/card_list_from_deck.dart';
import 'package:ninenty_second_per_word_app/frontend/style/app_colors.dart';
import 'package:ninenty_second_per_word_app/provider/deck_provider.dart';
import 'package:ninenty_second_per_word_app/provider/schedule_provider.dart';
import 'package:provider/provider.dart';

class DeckListPage extends StatelessWidget {
  const DeckListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var modelDeck = context.watch<DeckProvider>();
    var scheduleProvider = context.watch<ScheduleProvider>();
    void showCustomDialog({
      //! costom dialog
      required BuildContext context,
      required String title,
      required String description,
      required String confirmText,
      required String cancelText,
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
                          backgroundColor: AppColors.redColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          cancelText,
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Poppins'),
                        ),
                      ),
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

    void showCustomDialogWithTextField({
      required BuildContext context,
      required String title,
      required String description,
      required String confirmText,
      required String cancelText,
      required VoidCallback onConfirm,
    }) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: const Color.fromARGB(255, 34, 34, 34),
            title: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.edit,
                    color: AppColors.greenColor,
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
                  Container(
                    width: double.maxFinite, // Сделаем диалог немного шире
                    child: TextField(
                      controller: modelDeck.deckName, //! Добавил контроллер
                      style: TextStyle(color: Colors.white),
                      maxLines:
                          3, // Ограничение по строкам для многострочного ввода
                      minLines: 1, // Минимум 1 строка
                      decoration: InputDecoration(
                        hintText: 'Enter text...',
                        hintStyle: TextStyle(
                            color: Colors.grey, fontFamily: 'Poppins'),
                        filled: true,
                        fillColor: Colors.black54,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.redColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(cancelText,
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Poppins')),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.greenColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (modelDeck.deckName.text.isNotEmpty) {
                            onConfirm();
                            Navigator.pop(context);
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.black87,
                                title: const Text(
                                  'Please enter text',
                                  style: TextStyle(color: Colors.white),
                                ),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: Text(
                          confirmText,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // Добавляем ограничение по ширине для диалога
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ValueListenableBuilder(
        valueListenable: HiveBox.deck.listenable(),
        builder: (context, Box<DeckModel> deck, _) {
          final decks = deck.values.toList();
          if (decks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.dangerous_outlined,
                    size: 55,
                    color: Color.fromARGB(157, 243, 243, 243),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'You have no decks',
                    style: TextStyle(
                      color: Color.fromARGB(157, 243, 243, 243),
                      fontSize: 19,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
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
                        onPressed: () {
                          showCustomDialogWithTextField(
                            context: context,
                            title: 'Create a deck',
                            description: 'Give a name to your deck',
                            confirmText: 'Create',
                            cancelText: 'Cancel',
                            onConfirm: () {
                              modelDeck.createDeck();
                            },
                          );
                        },
                        child: Text(
                          'Create your first deck',
                          style: TextStyle(
                            color: const Color.fromARGB(157, 243, 243, 243),
                            fontFamily: 'Poppins',
                            fontSize: 15.5, // Подкорректировал размер шрифта
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
              itemBuilder: (context, index) {
                final currentDeck = decks[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CardList(
                                  deckIndex: index,
                                )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        height: 120,
                        color: Colors.grey,
                        child: Center(
                          child: ListTile(
                              subtitle: Text(
                                currentDeck.card.isEmpty
                                    ? 'No cards '
                                    : 'Cards: ${currentDeck.card.length}',
                                style: TextStyle(fontSize: 14),
                              ),
                              trailing: SizedBox(
                                width: 144,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if (!currentDeck.isStarted)
                                      IconButton(
                                          onPressed: () {
                                            modelDeck.cardText.clear();
                                            modelDeck.cardSubText.clear();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddingCardPage(
                                                          index: index,
                                                        )));
                                          },
                                          icon: Icon(Icons.add)),
                                    currentDeck.isLearned
                                        ? _SpecialIcon(icon: Icons.check_box)
                                        : (!currentDeck.isStarted)
                                            ? IconButton(
                                                onPressed: () {
                                                  currentDeck.card.isEmpty
                                                      ? ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'You have no card in this deck. You can not start the process',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontFamily:
                                                                      'Poppins'),
                                                            ),

                                                            duration: Duration(
                                                                seconds:
                                                                    1), // Длительность показа
                                                          ),
                                                        )
                                                      : showCustomDialog(
                                                          context: context,
                                                          title:
                                                              'Start Process',
                                                          description:
                                                              'Do you want to start this deck? You will not be able to add new cards or edit existing ones after starting.',
                                                          confirmText: 'Start',
                                                          cancelText: 'Cancel',
                                                          onConfirm: () {
                                                            print(
                                                                'Starting deck at index: $index');
                                                            scheduleProvider
                                                                .startDeck(
                                                                    index);
                                                          },
                                                        );
                                                },
                                                icon: const Icon(
                                                  Icons.play_arrow,
                                                ),
                                              )
                                            : IconButton(
                                                onPressed: () {
                                                  showCustomDialog(
                                                    context: context,
                                                    title: 'Cancel Process',
                                                    description:
                                                        'Do you want to cancel the process of this deck? The progress will be lost.',
                                                    confirmText: 'Cancel',
                                                    cancelText: 'Keep',
                                                    onConfirm: () {
                                                      print(
                                                          'Canceling deck at index: $index');
                                                      scheduleProvider
                                                          .cancelDeck(index);
                                                    },
                                                  );
                                                },
                                                icon: const Icon(Icons.stop),
                                              ),
                                    IconButton(
                                      onPressed: () {
                                        showCustomDialog(
                                          context: context,
                                          title: 'Delete Deck',
                                          description:
                                              'Are you sure you want to delete this deck? This action cannot be undone.',
                                          confirmText: 'Delete',
                                          cancelText: 'Cancel',
                                          onConfirm: () async {
                                            print(
                                                'Deleting deck at index: $index');
                                            await modelDeck.deleteDeck(
                                                context, index);
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              title: _SpecialText(
                                  fontSize: 18,
                                  text: currentDeck.name
                                      .toString()
                                      .toUpperCase())),
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(),
              itemCount: deck.length);
        },
      ),
    );
  }
}

class _SpecialIcon extends StatelessWidget {
  IconData icon;
  _SpecialIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Transform.translate(
              offset: const Offset(-4, 0), // Подкорректировал смещение текста
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
                child: Icon(icon, size: 30, color: Colors.white),
              ),
            ),
          ),
        ],
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
        ],
      ),
    );
  }
}
