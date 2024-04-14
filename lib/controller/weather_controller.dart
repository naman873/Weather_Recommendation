import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/weather_model.dart';

class WeatherController extends ChangeNotifier {
  List<WeatherModel> weatherData = [];
  bool loader = false;

  void getAllWeathers(String cities) async {
    weatherData = [];
    loader = true;
    notifyListeners();
    List<String> cityList = cities.split(",");
    for (int i = 0; i < cityList.length; i++) {
      WeatherModel weather = await getCityWeather(cityList[i]);
      if (weather.name == "") {
      } else {
        weatherData.add(weather);
      }
    }
    loader = false;
    notifyListeners();
    // debugPrint(weatherData.length.toString());
  }

  Future<WeatherModel> getCityWeather(String cityName) async {
    var url =
        '${Constants.openWeatherMapUrl}?q=$cityName&appid=${Constants.apikey}&units=metric';
    http.Response res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      WeatherModel weatherModel = WeatherModel.fromJson(jsonDecode(res.body));
      debugPrint(weatherModel.name);
      return weatherModel;
    } else {
      WeatherModel weatherModel = WeatherModel(name: "");
      return weatherModel;
    }
  }
}
