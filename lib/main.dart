import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screen.dart';
import 'theme_provider.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: ThemeData.light(useMaterial3: true),
            darkTheme: ThemeData.dark(useMaterial3: true),
            home: AnimatedTheme(
              duration: Duration(milliseconds: 50),
              data: themeProvider.themeMode == ThemeMode.light ? ThemeData.light() : ThemeData.dark(),
              child: Screen(),
            )
          );
        },
      ),
    );
  }
  }

