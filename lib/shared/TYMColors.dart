import 'package:flutter/material.dart';
class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xffB5954E, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffF5F5F5),//10%
      100: Color(0xffDED0B0),//20%
      200: Color(0xffbeab9f),//30%
      300: Color(0xffd4c4bc),//40%
      400: Color(0xffeacbb4),//50%
      500: Color(0xffb49c8f),//60%
      600: Color(0xffb5a494),//70%
      700: Color(0xffac968c),//80%
      800: Color(0xffB5954E),//90%
      900: Color(0xff171717),//100%
    },
  );

  static const Color tymDark = Color(0xffB5954E);
  static const Color tymLight = Color(0xffF1ECDF);
}


