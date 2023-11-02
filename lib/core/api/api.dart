import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/forecast.dart';

class ApiRepo {
  static const String baseUrl = "https://api.weatherapi.com/v1/";

  // Future<bool> internet() async {
  //   final result = await http.get(Uri.parse("https://api.weatherapi.com"));
  //   if (result.statusCode == 200) {
  //     print("true");
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<Forecast> getMyForecast(String location) async {
    try {
      final result = await http
          .get(Uri.parse("${baseUrl}forecast.json").replace(queryParameters: {
        "q": location,
        "days": "7",
        "key": "5fbe43cdd5b04a19a7901237233110",
        "aqi": "yes",
        "alerts": "yes"
      }));
      return Forecast.fromJson(jsonDecode(result.body));
    } catch (e) {
      rethrow;
    }
  }


  Future<List<String>> autoComplete(String location) async {
    try {
      final result = await http
          .get(Uri.parse("${baseUrl}search.json").replace(queryParameters: {
        "q": location,
        "key": "5fbe43cdd5b04a19a7901237233110",
      }));
      return (jsonDecode(result.body) as List)
          .map((e) => e["name"].toString())
          .toList();
    } catch (e) {
      rethrow;
    }
  }


}
