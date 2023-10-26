import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';

class ThemeConfig {
  static ThemeData createTheme({
    required Brightness brightness,
    required Color background,
    required Color primaryText,
    required Color secondaryText,
    required Color accentColor,
    required Color divider,
    required Color buttonBackground,
    required Color buttonText,
    required Color cardBackground,
    required Color disabled,
    required Color error,
    required Color textButtonColor,
    required Color hintColor,
    required Color textFieldColor,
    required Color checkBoxColor,
    required Color iconColor,
  }) {
    final baseTextTheme = brightness == Brightness.dark
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    return ThemeData(
      brightness: brightness,
      // buttonColor: buttonBackground,
      canvasColor: background,
      cardColor: background,
      dividerColor: divider,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: MyColors.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: MyRadius.sm,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: divider,
        space: 1,
        thickness: 1,
      ),
      cardTheme: CardTheme(
        color: cardBackground,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all<Color>(checkBoxColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),

      backgroundColor: background,
      primaryColor: accentColor,
      // accentColor: accentColor,
      toggleableActiveColor: accentColor,
      appBarTheme: AppBarTheme(
        // brightness: brightness,
        color: cardBackground,
        // textTheme: TextTheme(
        //   bodyText1: baseTextTheme.bodyText1!.copyWith(
        //     color: secondaryText,
        //     fontSize: 18,
        //   ),
        // ),
        iconTheme: IconThemeData(
          color: iconColor,
        ),
      ),
      iconTheme: IconThemeData(
        color: secondaryText,
        size: 16.0,
      ),
      errorColor: error,
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme(
          brightness: brightness,
          primary: accentColor,
          // primaryVariant: accentColor,
          secondary: accentColor,
          // secondaryVariant: accentColor,
          surface: background,
          background: background,
          error: error,
          onPrimary: buttonText,
          onSecondary: buttonText,
          onSurface: buttonText,
          onBackground: buttonText,
          onError: buttonText,
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            primary: textButtonColor,
            textStyle: baseTextTheme.headlineSmall!.copyWith(
              color: primaryText,
              fontFamily: 'iran',
            )),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: accentColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
          errorStyle: TextStyle(color: error),
          labelStyle: TextStyle(
            fontFamily: 'iran',
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
            color: primaryText.withOpacity(0.5),
          ),
          hintStyle: TextStyle(
            color: hintColor,
            fontSize: 13.0,
            fontWeight: FontWeight.w300,
          ),
          contentPadding: const EdgeInsets.all(0),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey))),
      fontFamily: 'iran',
      textTheme: TextTheme(
        bodyLarge: baseTextTheme.bodyLarge!.copyWith(
          color: secondaryText,
          fontFamily: 'iran',
        ),
        bodyMedium: baseTextTheme.bodyMedium!.copyWith(
          color: secondaryText,
          fontFamily: 'iran',
        ),
        bodySmall: baseTextTheme.bodySmall!.copyWith(
          color: secondaryText,
          fontFamily: 'iran',
        ),
        displaySmall: baseTextTheme.displaySmall!.copyWith(
          color: secondaryText,
          fontFamily: 'iran',
        ),
        displayLarge: baseTextTheme.displayLarge!.copyWith(
          color: secondaryText,
          fontFamily: 'iran',
        ),
        displayMedium: baseTextTheme.displayMedium!.copyWith(
          color: secondaryText,
          fontFamily: 'iran',
        ),
        headlineSmall: baseTextTheme.headlineSmall!.copyWith(
          color: secondaryText,
          fontFamily: 'iran',
        ),
        headlineMedium: baseTextTheme.headlineMedium!.copyWith(
          color: secondaryText,
          fontFamily: 'iran',
        ),
        headlineLarge: baseTextTheme.headlineLarge!.copyWith(
          color: secondaryText,
          fontFamily: 'iran',
        ),
      ),
    );
  }

  static ThemeData get lightTheme => createTheme(
      brightness: Brightness.dark,
      background: MyColors.black.shade700,
      cardBackground: MyColors.black.shade400,
      primaryText: MyColors.primary,
      secondaryText: MyColors.secondary,
      accentColor: MyColors.primary,
      divider: MyColors.black.shade400,
      buttonBackground: MyColors.primary,
      buttonText: MyColors.white,
      disabled: MyColors.black,
      error: MyColors.error,
      textButtonColor: MyColors.white,
      hintColor: MyColors.black.shade400,
      textFieldColor: MyColors.black,
      checkBoxColor: MyColors.primary,
      iconColor: MyColors.black);
}
