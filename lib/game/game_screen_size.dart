import 'package:flame/components.dart';

mixin GameScreenSize on Component {
  Vector2 gameSize = Vector2(400, 900);

  void onResize(Vector2 newGameSize) {
    gameSize = newGameSize;
  }
}


// static List<String> list = [
//   "BANANA",
//   "LADIES",
//   "HELPER",
//   "ANGRY",
//   "ACID",
//   "AREA",
//   "HOME",
//   "ANT",
//   "TWO",
//   "NAME",
//   "ZEBRA",
//   "YALK",
//   "HUMAN",
//   "POLICE",
//   "KITE",
//   "ISLAND",
//   "SOAP",
//   "LIZARD",
//   "CEMENT",
//   "LIQUID",
//   "SIMPLE",
//   "MOSQUE",
//   "TEMPLE",
//   "CHURCH",
// ];

