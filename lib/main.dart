import 'package:calculator/calculator.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return DynamicColorBuilder(builder: ((ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      return GetMaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightDynamic ?? _defaultLightColorScheme,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkDynamic ?? _defaultDarkColorScheme,
        ),
        home: const Calc(),
      );
    }));
  }
}

final _defaultLightColorScheme = ColorScheme.fromSeed(seedColor: Colors.green);

final _defaultDarkColorScheme = ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.dark);
