import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'e776d459538ebb33a43037823022964e';
class WeatherModel {

  Future<Map<String, dynamic>> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    var url = Uri.https('api.openweathermap.org', 'data/2.5/weather', {
      'lat': '${location.latitude}',
      'lon': '${location.longitude}',
      'appid': apiKey,
      'units': 'metric'
    });

    NetworkHelper networkHelper = NetworkHelper();
    Map<String, dynamic> weatherData = await networkHelper.getData(url);

    return weatherData;
  }

  Future<Map<String, dynamic>> getCityWeather(String cityName) async {
    var url = Uri.https('api.openweathermap.org', 'data/2.5/weather', {
      'q' : cityName,
      'appid': apiKey,
      'units': 'metric'
    });

    print(url);

    NetworkHelper networkHelper = NetworkHelper();
    Map<String, dynamic> weatherData = await networkHelper.getData(url);

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
