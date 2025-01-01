import 'package:hive/hive.dart';

part 'CardModel.g.dart';

@HiveType(typeId: 1)
class CardModel {
  @HiveField(0)
  String? cardText;

  @HiveField(1)
  String? cardSubText;

    @HiveField(2)
  bool? isFavourite;



  CardModel(this.cardText, this.cardSubText, {this.isFavourite = false});
}
