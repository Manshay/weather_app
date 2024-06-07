// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/weather_api.dart';
import 'package:weather_app/weather_card.dart';
import 'package:weather_app/weather_details.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'get_weather_icon.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  late Future<Map<String,dynamic>> weather;
  String cityName = 'New Delhi'; // Default city name
  List<String> cities = ['New Delhi'];

  Future<Map<String,dynamic>> getCurrentWeather(String cityName) async {
    try {
      final res = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$weatherAPIKey&units=metric'));
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw data['message'];
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  String getTime(String dt) {
    final dateTime = DateTime.parse(dt);
    final formattedTime = DateFormat('h:mm a').format(dateTime);
    return formattedTime;
  }

  void _showAddCityDialog() {
    String newCityName = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add City'),
          content: TextField(
            onChanged: (value) {
              newCityName = value;
            },
            decoration: InputDecoration(hintText: "Enter city name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newCityName.isNotEmpty) {
                  setState(() {
                    cityName = newCityName;
                    cities.add(newCityName);
                    weather = getCurrentWeather(cityName);
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather(cityName);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            themeProvider.themeMode == ThemeMode.dark ? Icons.nightlight : Icons.wb_sunny,
            color: themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.yellow,
          ),
          onPressed: () {
            themeProvider.switchTheme();
          },
        ),
        title: Text(
          'WeCast',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
            fontFamily: 'Lato',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _showAddCityDialog,
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                weather = getCurrentWeather(cityName);
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          final weatherData = data['list'][0];
          final currentTemp = weatherData['main']['temp'];
          final currentWeather = weatherData['weather'][0]['main'];
          final pressure = '${weatherData['main']['pressure']} hPa';
          final wind = '${weatherData['wind']['speed']} m/s';
          final humidity = '${weatherData['main']['humidity']} %';

          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on, color: Colors.red),
                                  SizedBox(width: 5),
                                  Text(
                                    cityName,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '$currentTemp°C',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontFamily: 'Lato',
                                ),
                              ),
                              const SizedBox(height: 10),
                              Icon(
                                getWeatherIcon(currentWeather),
                                size: 70,
                                color: getWeatherIconColor(currentWeather, themeProvider.themeMode),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                currentWeather,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Lato',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                //forecast cards
                Text(
                  'Hourly Forecast',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < 12; i++)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0), // Add some padding to the right of each card
                          child: WeatherCard(
                            time: getTime(data['list'][i + 1]['dt_txt']),
                            weather: data['list'][i + 1]['weather'][0]['main'],
                            temperature: '${data['list'][i + 1]['main']['temp']} °C',
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                //additional info
                Text(
                  'Weather Details',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WeatherDetail(
                      icon: Icons.water_drop,
                      title: 'Humidity',
                      value: humidity,
                      iconColor: themeProvider.themeMode == ThemeMode.light ? Colors.black : Colors.white,
                    ),
                    WeatherDetail(
                      icon: Icons.air,
                      title: 'Wind',
                      value: wind,
                      iconColor: themeProvider.themeMode == ThemeMode.light ? Colors.black : Colors.white,
                    ),
                    WeatherDetail(
                      icon: Icons.thermostat,
                      title: 'Pressure',
                      value: pressure,
                      iconColor: themeProvider.themeMode == ThemeMode.light ? Colors.black : Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
