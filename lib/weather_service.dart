import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  static const String _apiKey = 'YOUR_API_KEY'; // Replace with your OpenWeatherMap API key
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  // Method to get the current location of the user
  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error('Location permission denied');
      }
    }

    // Get current position
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // Method to fetch weather data using latitude and longitude
  static Future<Map<String, dynamic>?> getWeather(
      double latitude, double longitude) async {
    final url = Uri.parse(
        '$_baseUrl?lat=$latitude&lon=$longitude&appid=$_apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data; // Return the weather data
    } else {
      return null;
    }
  }

  // Method to fetch and return weather data
  static Future<Map<String, String>> fetchWeatherData() async {
    try {
      Position? position = await getCurrentLocation();
      if (position != null) {
        var weatherData = await getWeather(
          position.latitude,
          position.longitude,
        );
        if (weatherData != null) {
          String weather = weatherData['weather'][0]['description'] ?? 'No data';
          String temperature = '${weatherData['main']['temp']}°C';
          return {'weather': weather, 'temperature': temperature};
        }
      }
      return {'weather': 'Failed to fetch weather', 'temperature': ''};
    } catch (e) {
      return {'weather': 'Failed to fetch weather', 'temperature': ''};
    }
  }

  // This method will call the provided callback with the weather data
  static Future<void> fetchWeatherAndUpdateState(Function(Map<String, String>) callback) async {
    var weatherData = await fetchWeatherData();
    callback(weatherData);  // Pass the weather data back to the caller
  }
}
