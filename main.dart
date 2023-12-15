import 'package:flutter/material.dart';
import 'package:expense_tracker/wdgets/expenses.dart';
// import 'package:flutter/services.dart';flutter pub add flutter_riverpod

final kscheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));
final kdarkscheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125));

main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((fn) {

  //     });
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kdarkscheme,
        cardTheme: const CardTheme().copyWith(
          color: kdarkscheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kdarkscheme.primaryContainer,
                foregroundColor: kdarkscheme.onPrimaryContainer)),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kscheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kscheme.onPrimaryContainer,
            foregroundColor: kscheme.primaryContainer),
        cardTheme: const CardTheme().copyWith(
          color: kscheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kscheme.primaryContainer)),
        textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: kscheme.onSecondaryContainer,
              fontSize: 18,
            )),
      ),
      home: const Expenses(),
    ),
  );
}
