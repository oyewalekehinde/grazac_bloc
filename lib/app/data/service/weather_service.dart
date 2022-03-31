import 'dart:convert';
import 'dart:io';

import 'package:grazac_bloc/app/data/model/weather_model.dart';
import 'package:tuple/tuple.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

const String API_KEY = "60f988bd707e9624b1fc62ad190c8c6c";
const String BASE_URL = "https://api.openweathermap.org/data/2.5/weather?q=";

class WeatherService {
  Future<Tuple2<WeatherModel?, String?>> getWeatherByCity(
      {String? city}) async {
    final url = Uri.parse(BASE_URL + "$city&appid=$API_KEY");
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        WeatherModel data = WeatherModel.fromJson(json.decode(response.body));
        return Tuple2(data, null);
      } else {
        return Tuple2(null, "unable to get Weather data");
      }
    } catch (e) {
      if (e is SocketException) {
        return Tuple2(null, "No Internet Connection");
      }
      return Tuple2(null, "unable to get Weather data");
    }
  }
  // Future<Tuple2<WeatherModel?, String?>> getWeatherByCity(
  //     {String? city}) async {
  //   Dio _dio = Dio();
  //   final url = BASE_URL + "$city&appid=$API_KEY";
  //   try {
  //     var response = await _dio.get(url);

  //     if (response.statusCode == 200) {
  //       WeatherModel data = WeatherModel.fromJson(response.data);

  //       return Tuple2(data, null);
  //     } else {
  //       return Tuple2(null, "unable to get Weather data");
  //     }
  //   } catch (e) {
  //     if (e is SocketException) {
  //       return Tuple2(null, "No Internet Connection");
  //     } else {
  //       return Tuple2(null, "unable to get Weather data");
  //     }
  //   }
  // }
}
