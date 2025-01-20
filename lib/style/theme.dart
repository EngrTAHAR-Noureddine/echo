import 'package:echo/constant/app_color.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  /// private constructor
  CustomTheme._();

  /// the one and only instance of this singleton
  static final of = CustomTheme._();

  ThemeData lightMode = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: AppColor.white,
    dividerColor: AppColor.lightGrey01,
    indicatorColor: AppColor.lightGrey03,
    cardColor: AppColor.white,
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,

      primary: AppColor.lightBlue,
      onPrimary: AppColor.white,

      primaryFixed: AppColor.lightPurple,
      primaryFixedDim: AppColor.white,

      secondary: AppColor.lightOrange,
      onSecondary: AppColor.dark,

      secondaryContainer: AppColor.lightGreen,
      onSecondaryContainer: AppColor.white,

      error: AppColor.lightRed,
      errorContainer: AppColor.lightRed,

      onError: AppColor.white,
      onErrorContainer: AppColor.white,

      outline: AppColor.lightYellow,
      outlineVariant: AppColor.dark,

      // primaryContainer: Color(0xFF040B1A),
      // onPrimaryContainer: Color(0xFF344054),

      // surface: Color(0xFF667085),
      // onSurface: Color(0xFF98A2B3),

      // onSecondaryFixed: Color(0xFFD0D5DD),
      // onSecondaryFixedVariant: Color(0xFFF2F4F7),

      // inverseSurface: Color(0xFFF2F4F7),
      // onInverseSurface: Color(0xFFE0E0E0),

      scrim: AppColor.dark,
    ),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.white,
      selectedItemColor: AppColor.lightBlue,
      unselectedItemColor: AppColor.lightGrey03,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColor.white, //Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      hintStyle: const TextStyle(
        color: AppColor.lightGrey02,
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.lightGrey01, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.lightGrey02, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.lightBlue, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.lightBlue, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.lightRed, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.lightRed, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: WidgetStateProperty.all<Color>(AppColor.lightBlue),
            foregroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
            overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
            padding:
                WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(16)),
            elevation: WidgetStateProperty.all<double>(0),
            shape:
                WidgetStateProperty.all<OutlinedBorder>(const StadiumBorder())
            // shape: WidgetStateProperty.all<OutlinedBorder>(RoundedRectangleBorder( borderRadius: BorderRadius.circular(hugeRadiusValue) ))
            )),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
        overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
        padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(16)),
        elevation: WidgetStateProperty.all<double>(0),
        shape: WidgetStateProperty.all<OutlinedBorder>(const StadiumBorder()),
        // shape: WidgetStateProperty.all<OutlinedBorder>(RoundedRectangleBorder( borderRadius: BorderRadius.circular(hugeRadiusValue) ))
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: WidgetStateProperty.all<Color>(AppColor.lightBlue),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
          overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
          padding:
              WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(14)),
          elevation: WidgetStateProperty.all<double>(0),
          shape: WidgetStateProperty.all<OutlinedBorder>(
              const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))))),
    ),
    textTheme: const TextTheme(
      /// Body
      bodySmall: TextStyle(
          fontSize: 12,
          color: AppColor.dark,
          overflow: TextOverflow.visible,
          fontWeight: FontWeight.w400), // small text

      bodyMedium: TextStyle(
          fontSize: 14,
          color: AppColor.dark,
          overflow: TextOverflow.visible,
          fontWeight: FontWeight.w400), // normal text

      bodyLarge: TextStyle(
          color: AppColor.dark,
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.visible,
          fontSize: 16), // big text

      ///Labels
      labelSmall: TextStyle(
          color: AppColor.dark,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.visible,
          fontSize: 14),
      labelMedium: TextStyle(
          color: AppColor.dark,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.visible,
          fontSize: 16),
      labelLarge: TextStyle(
          color: AppColor.dark,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.visible,
          fontSize: 18),

      /// Display
      displaySmall: TextStyle(
          fontSize: 14,
          color: AppColor.dark,
          overflow: TextOverflow.visible,
          fontWeight: FontWeight.w600),

      displayMedium: TextStyle(
          fontSize: 16,
          color: AppColor.dark,
          overflow: TextOverflow.visible,
          fontWeight: FontWeight.w600),

      displayLarge: TextStyle(
          color: AppColor.dark,
          fontWeight: FontWeight.w600,
          overflow: TextOverflow.visible,
          fontSize: 18),

      /// Headline
      headlineSmall: TextStyle(
          fontSize: 14,
          color: AppColor.dark,
          overflow: TextOverflow.visible,
          fontWeight: FontWeight.w700),

      headlineMedium: TextStyle(
          fontSize: 16,
          color: AppColor.dark,
          overflow: TextOverflow.visible,
          fontWeight: FontWeight.w700),

      headlineLarge: TextStyle(
          color: AppColor.dark,
          fontWeight: FontWeight.w700,
          overflow: TextOverflow.visible,
          fontSize: 18),

      ///Titles
      titleSmall: TextStyle(
          color: AppColor.dark,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.visible,
          fontSize: 20),
      titleMedium: TextStyle(
          color: AppColor.dark,
          fontWeight: FontWeight.w600,
          overflow: TextOverflow.visible,
          fontSize: 24),
      titleLarge: TextStyle(
          color: AppColor.dark,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.visible,
          fontSize: 50), // Done
    ),
  );
}
