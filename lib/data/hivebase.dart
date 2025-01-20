import 'dart:io';

import 'package:echo/constant/enums.dart';
import 'package:hive/hive.dart';

class HiveBase {
  static HiveBase hiveBase = HiveBase();

  late Box setting;

  static Future init() async {
    var path = Directory.current.path;
    Hive.init(path);
    hiveBase.setting = await Hive.openBox("settingBox");
  }

  /// Setter ------------------------------------------------------------------
  Future<void> setLanguage(LanguageCode language) async =>
      await setting.put("language", language.name);

  /// Getter -----------------------------------------------------------------
  LanguageCode getLanguage() => LanguageCode.values
      .byName(setting.get("language", defaultValue: LanguageCode.eng.name));
}
