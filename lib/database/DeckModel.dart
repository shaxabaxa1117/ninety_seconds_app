import 'package:hive/hive.dart';
import 'package:ninenty_second_per_word_app/database/CardModel.dart';
part 'DeckModel.g.dart';

@HiveType(typeId: 0)
class DeckModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<CardModel> card;

  @HiveField(2)
  DateTime? lastShowDate;

  @HiveField(3)
  DateTime? nextShowDate;

  @HiveField(4)
  bool isStarted;

  @HiveField(5) // Убедитесь, что номер поля не пересекается с другими
  int timesShown;

  @HiveField(6) // Используйте следующий доступный номер
  bool isLearned;

  DeckModel({
    required this.name,
    required this.card,
    this.lastShowDate,
    this.nextShowDate,
    this.isStarted = false,
    this.timesShown = 0,
    this.isLearned = false, // По умолчанию колода считается невыученной
  });
}
