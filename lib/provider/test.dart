import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ninenty_second_per_word_app/database/DeckModel.dart';
import 'package:ninenty_second_per_word_app/database/hive_box.dart';

/// Провайдер для управления расписанием показа колод
class Test extends ChangeNotifier {
  List<DeckModel> _todayDecks = [];

  List<DeckModel> get todayDecks => _todayDecks;

  ScheduleProvider() {
    checkAndUpdateDecks();
  }

void checkAndUpdateDecks() async {
  final deckBox = HiveBox.deck;
  final now = DateTime.now();

  _todayDecks.clear();
  print('Checking decks at $now');

  for (int i = 0; i < deckBox.length; i++) {
    final deck = deckBox.getAt(i);
    if (deck != null) {
      print('Deck: ${deck.name}, Next Show Date: ${deck.nextShowDate}, Is Learned: ${deck.isLearned}, Is Started: ${deck.isStarted}');
      if (!deck.isLearned && 
          deck.isStarted && 
          deck.nextShowDate != null && 
          deck.nextShowDate!.isBefore(now)) {
        _todayDecks.add(deck);
        print('Added deck: ${deck.name}, Next Show Date: ${deck.nextShowDate}');
      }
    }
  }
  print('Total decks to show today: ${_todayDecks.length}');
  notifyListeners();
}

void markDeckAsShown(int index) async {
  final deckBox = HiveBox.deck;
  final deck = _todayDecks[index];

  // Обновляем дату последнего показа
  deck.lastShowDate = DateTime.now();

  // Устанавливаем следующую дату показа или помечаем как выученную
  if (deck.timesShown < 7) {
    deck.nextShowDate = DateTime.now().add(Duration(seconds: 10));
    print('${deck.timesShown} раз показоно');
  } else if (deck.timesShown == 7) {
    deck.nextShowDate = DateTime.now().add(Duration(seconds: 15));
    print('Прошла неделя');
    print('${deck.timesShown} раз показоно');

  } else if (deck.timesShown == 8) {
     print('Прошли 2 недели');
     print('${deck.timesShown} раз показоно');
    deck.nextShowDate = DateTime.now().add(Duration(seconds: 10));
    print('${deck.timesShown} раз показоно');
     print('конец');
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

  // Сообщаем слушателям об изменениях
  notifyListeners();

  print('Marked deck as shown: ${deck.name}, Is Learned: ${deck.isLearned}, Next Show Date: ${deck.nextShowDate}');
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
}