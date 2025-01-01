import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ninenty_second_per_word_app/database/DeckModel.dart';
import 'package:ninenty_second_per_word_app/database/hive_box.dart';

/// Провайдер для управления расписанием показа колод
class ScheduleProvider extends ChangeNotifier {
  List<DeckModel> _todayDecks = [];
  List<DeckModel> get todayDecks => _todayDecks;
  bool isLoading = false;

  ScheduleProvider() {
    checkAndUpdateDecks();
  }

  Future<void> checkAndUpdateDecks() async {
    final deckBox = HiveBox.deck;
    final now = DateTime.now();

    _todayDecks.clear();
    print('Checking decks at $now');

    for (int i = 0; i < deckBox.length; i++) {
      final deck = deckBox.getAt(i);
      if (deck != null) {
        print(
            'Deck: ${deck.name}, Next Show Date: ${deck.nextShowDate}, Is Learned: ${deck.isLearned}, Is Started: ${deck.isStarted}');
        if (!deck.isLearned &&
            deck.isStarted &&
            deck.nextShowDate != null &&
            deck.nextShowDate!.isBefore(now)) {
          _todayDecks.add(deck);
          print(
              'Added deck: ${deck.name}, Next Show Date: ${deck.nextShowDate}');
        }
      }
    }
    print('Total decks to show today: ${_todayDecks.length}');

    notifyListeners();
  }

  void markDeckAsShown(int deckIndex) async {
    final deckBox = HiveBox.deck;
    final index = _todayDecks.indexWhere((d) => d == deckBox.values.toList()[deckIndex]);
    if (index == -1) {
      print('Deck not found in today\'s decks');
      return;
    }
  final deck = deckBox.values.toList()[deckIndex];

    // Обновляем дату последнего показа
    deck.lastShowDate = DateTime.now();

    // Устанавливаем следующую дату показа или помечаем как выученную
    if (deck.timesShown < 7) {
      deck.nextShowDate = DateTime.now().add(Duration(days: 1));
    } else if (deck.timesShown == 7) {
      deck.nextShowDate = DateTime.now().add(Duration(days: 7));
    } else if (deck.timesShown == 8) {
      deck.nextShowDate = DateTime.now().add(Duration(days: 14));
    } else {
      // Колода считается выученной после 9-го показа
      deck.isLearned = true;
      deck.nextShowDate = null; // Больше не показываем
    }

    // Увеличиваем счетчик показов
    deck.timesShown += 1;

    // Сохраняем изменения в Hive
    await deckBox.putAt(deckBox.values.toList().indexOf(deck), deck);

    // Удаляем колоду из отображаемого списка
    _todayDecks.removeAt(index);

    notifyListeners();

    print(
        'Marked deck as shown: ${deck.name}, Is Learned: ${deck.isLearned}, Next Show Date: ${deck.nextShowDate}');
  }

  void startDeck(int index) async {
    final deckBox = HiveBox.deck;
    final deck = deckBox.getAt(index);
    if (deck != null) {
      deck.isStarted = true;
      deck.nextShowDate = DateTime.now();
      await deckBox.putAt(index, deck);
      print('Started deck: ${deck.name}, Next Show Date: ${deck.nextShowDate}');
      checkAndUpdateDecks();
    }
  }

  void cancelDeck(int index) async {
    final deckBox = HiveBox.deck;
    final deck = deckBox.getAt(index);

    if (deck != null) {
      // Сбрасываем состояние колоды
      deck.isStarted = false;
      deck.nextShowDate = null;
      deck.isLearned = false;

      // Сохраняем изменения в Hive
      await deckBox.putAt(index, deck);

      print('Cancelled deck: ${deck.name} deck.isStarted :${deck.isStarted} deck.nextShowDate :${deck.nextShowDate} ${deck.name} ');
      checkAndUpdateDecks(); // Обновляем список отображаемых колод
    }
  }
}
