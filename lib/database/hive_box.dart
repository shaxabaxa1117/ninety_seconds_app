
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ninenty_second_per_word_app/database/CardModel.dart';
import 'package:ninenty_second_per_word_app/database/DeckModel.dart';



abstract class HiveBox{

  static final deck = Hive.box<DeckModel>('deck');
  static final favCards = Hive.box<CardModel>('fav_cards');

  


  

}