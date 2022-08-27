import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joke_app/constants/strings.dart';
import 'package:joke_app/model/joke_model.dart';

class DioService {
  Future<JokeModel?> getMethod(String url) async {
    Dio dio = Dio();

    return dio
        .get(url,
            options: Options(responseType: ResponseType.plain, method: 'GET'))
        .then((response) {
      if (response.statusCode == 200) {
        if (response.data != null) {
          final jsonBody = jsonDecode(response.data);
          final result = JokeModel.fromJson(jsonBody);
          return result;
        } else {
          return null;
        }
      } else if (response.statusCode == 404) {
        print('Internet error');
        return null;
      }
      return null;
    });
  }

  Future<void> getWeather(String cityName) async {
    Dio dioCilent = Dio();
    final url = weatherAPiUrl + cityName;
    final response = await dioCilent.get(url,
        options: Options(
            headers: {'X-Api-Key': apiKey}, responseType: ResponseType.plain));
    print(response.data);
  }
}
