import 'package:echo/constant/enums.dart';
import 'package:echo/translation/english_strings.dart';
import 'package:echo/translation/french_strings.dart';

import 'global_strings.dart';

class AppLanguage {
  static late GlobalStrings strings;

  static setStrings(LanguageCode language) {
    switch (language) {
      case LanguageCode.fr:
        strings = FrenchStrings();
        break;
      case LanguageCode.eng:
        strings = EnglishStrings();
        break;
    }
  }
}
