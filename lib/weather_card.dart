import 'package:flutter/material.dart';
import 'get_weather_icon.dart';

class WeatherCard extends StatelessWidget {
  final String time;
  final String weather;
  final String temperature;

  const WeatherCard({
    super.key,
    required this.time,
    required this.weather,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).iconTheme.color;
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Icon(
              getWeatherIcon(weather), // Convert weather condition string to IconData
              size: 32,
              color: weather == 'Humidity' ? Colors.blue : iconColor, // Use blue for humidity, otherwise use dynamic color
            ),
            const SizedBox(height: 8),
            Text(
              temperature,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
