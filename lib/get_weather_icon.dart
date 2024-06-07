import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

IconData getWeatherIcon(String weather) {
  switch (weather) {
    case 'Clouds':
      return Icons.cloud_sharp;
    case 'Clear':
      return Icons.wb_cloudy_outlined;
    case 'Rain':
      return Icons.cloudy_snowing;
    default:
      return Icons.error;
  }
}

Color getWeatherIconColor(String weather, ThemeMode themeMode) {
  return themeMode == ThemeMode.light ? Colors.black : Colors.white;
}