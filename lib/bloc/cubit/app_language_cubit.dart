import 'package:echo/constant/enums.dart';
import 'package:echo/data/hivebase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Theme Mode Cubit is to switch between Light and Dark Mode
class AppLanguageCubit extends Cubit<LanguageCode> {
  /// initial Language
  AppLanguageCubit(super.initialLanguage);

  /// set Language
  Future<void> setAppLanguage(LanguageCode language) async {
    await HiveBase.hiveBase.setLanguage(language);

    emit(language);
  }

  @override
  String toString() {
    LanguageCode code = HiveBase.hiveBase.getLanguage();
    return code.name;
  }
}
