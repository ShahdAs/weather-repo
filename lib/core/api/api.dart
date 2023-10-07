import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/core/model/current.dart';
import '../model/forecast.dart';

class ApiRepo {
  static const String baseUrl = "https://api.weatherapi.com/v1/";

  Future<CurrentModel> getMyCurrentLocation(String location) async {

    try {
      final result = await http.get(Uri.parse(
        "${baseUrl}current.json",
      ).replace(queryParameters: {
        "q": location,
        "key": "280a64967d164de8a82232719233108",
      }));
      return CurrentModel.fromMap(jsonDecode(result.body)["current"]);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Future<List<Forcast>> getMyForcast(String location) async {
  //   try{
  //     final result = await http
  //         .get(Uri.parse("${baseUrl}forecast.json").replace(queryParameters: {
  //       "q": location,
  //       "days": "7",
  //       "key": "280a64967d164de8a82232719233108",
  //     }));
  //     print(result.statusCode);
  //     return (jsonDecode(result.body)['forecast']['forecastday'] as List)
  //         .map((e) => Forcast.fromJson(e["day"]))
  //         .toList();
  //   }
  //   catch(e,s){
  //     print(e.toString());
  //     print(s);
  //     throw e;
  //   }
  // }

  Future<List<Forecast>> getMyForcast(String location) async {
    try{
      final result = await http
          .get(Uri.parse("${baseUrl}forecast.json").replace(queryParameters: {
        "q": location,
        "days": "7",
        "key": "280a64967d164de8a82232719233108",
        "aqi": "yes",
        "alerts" : "yes"
      }));
      print(result.statusCode);
      print('im hheeree');
      return (jsonDecode(result.body)['forecast']['forecastday'] as List)
          .map((e) => Forecast.fromJson(e))
          .toList();
    }
    catch(e,s){
      print(e.toString());
      print(s);
      throw e;
    }
  }

  Future<List<String>> autoComplete(String location) async {
    try{
      final result = await http
          .get(Uri.parse("${baseUrl}search.json").replace(queryParameters: {
        "q": location,
        "key": "280a64967d164de8a82232719233108",
      }));
      print(result.statusCode);
      print(result.body);
      return (jsonDecode(result.body) as List)
          .map((e) => e["name"].toString()).toList();
    }
    catch(e){
      throw e;
    }
  }
}
