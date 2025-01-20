import 'package:echo/constant/enums.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveBase {
  static HiveBase hiveBase = HiveBase();

  late Box setting;

  static Future init() async {
    await Hive.initFlutter();
    hiveBase.setting = await Hive.openBox("settingBox");
  }

  /// Setter ------------------------------------------------------------------
  Future<void> setLanguage(LanguageCode language) async =>
      await setting.put("language", language.name);

  Future<void> setToken(String token) async =>
      await setting.put("token", token);

  /// Getter -----------------------------------------------------------------
  LanguageCode getLanguage() => LanguageCode.values
      .byName(setting.get("language", defaultValue: LanguageCode.eng.name));

  String? getToken() => setting.get("token", defaultValue: null);
}
