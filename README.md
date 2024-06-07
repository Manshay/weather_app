# WeCast Weather App

WeCast is a beautiful weather application built with Flutter and Dart. It provides weather forecasts and detailed weather information for various cities around the world. The app features a clean and modern design, with theme-switching capabilities and also represents different weather conditions.

## Features

- **Current Weather:** Get the current weather information for your selected city.
- **Hourly Forecast:** View the hourly weather forecast.
- **Weather Details:** Detailed information including temperature, pressure, humidity, and wind speed.
- **Theme Switching:** Toggle between light and dark themes.
- **Add Multiple Cities:** Add and view weather information for multiple cities.

## App

[App.webm](https://github.com/Manshay/weather_app/assets/81351053/563d2ba8-c37c-4f5b-9d13-9ddba67a9490)

## Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://docs.flutter.dev/get-started/install)
- Dart SDK: [Install Dart](https://dart.dev/get-dart)
- Android Studio: [Install Android Studio](https://developer.android.com/studio)
- Visual Studio/Visual Studio Code

### Installation

1. **Clone the repository:**
   
   ```bash
   git clone https://github.com/yourusername/weather-app.git
   cd weather-app

3. Check that everything has been installed
   
   ```bash
   flutter doctor

2. Install dependencies
   
   ```bash
   flutter pub get

4. Run the app
   
   ```bash
   flutter run

## Usage

1. Select a City:
   
   By default, the app shows the weather for New Delhi. You can add new cities by clicking the add button in the top right corner.

2. Switch Themes:

   Use the theme switch button in the top left corner to toggle between light and dark themes.

3. Refresh Weather Data:

   Click the refresh button in the top right corner to update the weather information.

## Configuration

### API Key

WeCast uses the OpenWeatherMap API to fetch weather data. You need to get an API key from OpenWeatherMap and add it to your project.

1. Sign up and get your API from OpenWeatherMap
2. Add your API key to the `lib/weather_api.dart` file:
   
   ```bash
   const weatherAPIKey = 'API_KEY';

# Thank You!
