import 'package:flutter/material.dart';

import 'package:ninenty_second_per_word_app/database/CardModel.dart';
import 'package:ninenty_second_per_word_app/database/DeckModel.dart';
import 'package:ninenty_second_per_word_app/database/hive_box.dart';
import 'package:ninenty_second_per_word_app/provider/schedule_provider.dart';
import 'package:provider/provider.dart';

class DeckProvider extends ChangeNotifier {
  final TextEditingController deckName = TextEditingController();
  final TextEditingController cardText = TextEditingController();
  final TextEditingController cardSubText = TextEditingController();

  //! Создание новой колоды
  Future<void> createDeck() async {
    if (deckName.text.isNotEmpty) {
      print('Deck name: ${deckName.text}');
      await HiveBox.deck
          .add(
        DeckModel(name: deckName.text, card: []),
      )
          .then((_) {
        deckName.clear();
        notifyListeners();
      });
    }
  }

  //! Удаление колоды по индексу
  Future<void> deleteDeck(BuildContext context, int index) async {
    await HiveBox.deck.deleteAt(index);

    // Используем текущий провайдер через контекст
    final scheduleProvider =
        Provider.of<ScheduleProvider>(context, listen: false);
    await scheduleProvider.checkAndUpdateDecks();

    notifyListeners();
  }

  //! Добавление карточки в указанную колоду
  Future<void> addCard(
    int deckIndex,
  ) async {
    final _deckBox = HiveBox.deck;
    final deck = _deckBox.getAt(deckIndex);
    final card = CardModel(cardText.text, cardSubText.text, isFavourite: false);
    if (deck != null) {
      deck.card.add(card);
      await _deckBox.putAt(deckIndex, deck).then((_) {
        cardText.clear();
        cardSubText.clear();
        notifyListeners();
      });
    }
  }

  //! Удаление карточки из указанной колоды
  Future<void> deleteCard({
    required int deckIndex,
    required int cardIndex,
  }) async {
    final deck = HiveBox.deck.getAt(deckIndex);
    if (deck != null) {
      deck.card.removeAt(cardIndex);
      await HiveBox.deck.putAt(deckIndex, deck);
      notifyListeners();
    }
  }

  //! Сделать карточку избранной
  Future<void> setFavourite({
    required int deckIndex,
    required int cardIndex,
  }) async {
    final deck = HiveBox.deck.getAt(deckIndex);

    if (deck != null) {
      deck.card[cardIndex].isFavourite = !deck.card[cardIndex].isFavourite!;
      await HiveBox.deck.putAt(deckIndex, deck);
      notifyListeners();
    }
  }

  //! Редактирование карточки в указанной колоде
  Future<void> editCard({
    required int deckIndex,
    required int cardIndex,
  }) async {
    final deck = HiveBox.deck.getAt(deckIndex);

    if (deck != null) {
      deck.card[cardIndex].cardText = cardText.text;
      deck.card[cardIndex].cardSubText = cardSubText.text;
      await HiveBox.deck.putAt(deckIndex, deck);
      cardText.clear();
      cardSubText.clear();
      notifyListeners();
    }
  }

  //! Подготовка данных для редактирования карточки
  Future<void> prepareTextFields({
    required int deckIndex,
    required int cardIndex,
  }) async {
    final deck = HiveBox.deck.getAt(deckIndex);

    if (deck != null) {
      cardText.text = deck.card[cardIndex].cardText ?? '';
      cardSubText.text = deck.card[cardIndex].cardSubText ?? '';
      notifyListeners();
    }
  }

  Future<void> updateFavouritrCard() async {
    var allDecks = HiveBox.deck.values.toList();
    await HiveBox.favCards.clear();

    for (var i = 0; i < allDecks.length; i++) {
      for (var j = 0; j < allDecks[i].card.length; j++) {
        if (allDecks[i].card[j].isFavourite!) {
          await HiveBox.favCards.add(allDecks[i].card[j]);
        }
      }
    }
  }

//! Удаление карты из избранного
Future<void> removeFromFavourites(CardModel card) async {
  var allDecks = HiveBox.deck.values.toList();

  for (var deck in allDecks) {
    for (var cardInDeck in deck.card) {
      if (cardInDeck.cardText == card.cardText &&
          cardInDeck.cardSubText == card.cardSubText) {
        cardInDeck.isFavourite = false;
        break;
      }
    }
  }

  await HiveBox.deck.clear();
  for (var deck in allDecks) {
    await HiveBox.deck.add(deck);
  }

  final favCardsList = HiveBox.favCards.values.toList();
  final cardIndex = favCardsList.indexOf(card);

  if (cardIndex != -1) {
    await HiveBox.favCards.deleteAt(cardIndex);
    notifyListeners();
  }
}

  Future<void> addToFavourites(CardModel card) async {
    var allDecks = HiveBox.deck.values.toList();

    // Найти оригинальную карту в колодах
    for (var deck in allDecks) {
      for (var cardInDeck in deck.card) {
        if (cardInDeck.cardText == card.cardText &&
            cardInDeck.cardSubText == card.cardSubText) {
          cardInDeck.isFavourite = true;
          break;
        }
      }
    }

    // Обновить данные в Hive
    await HiveBox.deck.clear();
    for (var deck in allDecks) {
      await HiveBox.deck.add(deck);
    }

    // Добавить карту обратно в избранное
    await HiveBox.favCards.add(card);
    notifyListeners();
  }
}
