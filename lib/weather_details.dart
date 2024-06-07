import 'package:flutter/material.dart';

class WeatherDetail extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color iconColor;

  const WeatherDetail({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 50,
          color: iconColor,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 25,
            fontFamily: 'Lato',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontFamily: 'Lato',
          ),
        ),
      ],
    );
  }
}