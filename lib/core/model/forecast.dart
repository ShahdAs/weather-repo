import 'dart:convert';

class Forecast {
  Day day;
  Astro astro;
  List<Hour> hour;

  Forecast({required this.day, required this.astro, required this.hour});

  static Forecast fromJson(Map<String, dynamic> json) {
    return Forecast(
        day: Day.fromJson(json['day']),
        astro: Astro.fromJson(json['astro']),
        hour: (json['hour'] as List).map((e) =>
            Hour.fromJson(e)).toList()
    );
  }
}

class Astro {
  String sunset;
  String sunrise;

  Astro({
    required this.sunrise,
    required this.sunset
  });

  static Astro fromJson(Map<String, dynamic> json) {
    return Astro(
        sunrise: 'sunrise',
        sunset: 'sunset');
  }
}

class Hour {
  String time;
  int chance_of_rain;
  Condition condition;
  double temp_c;

  Hour({
    required this.condition,
    required this.temp_c,
    required this.chance_of_rain,
    required this.time
  });

  static Hour fromJson(Map<String, dynamic> json) {
    return Hour(
        condition: Condition.fromJson(json['condition']),
        temp_c: json['temp_c'],
        chance_of_rain: json['chance_of_rain'],
        time: json['time']);
  }

}

class Day {
  double uv;
  double avgtemp_c;
  int daily_chance_of_rain;
  double maxtemp_c;
  double mintemp_c;
  Condition condition;

  Day({
    required this.uv,
    required this.avgtemp_c,
    required this.daily_chance_of_rain,
    required this.maxtemp_c,
    required this.mintemp_c,
    required this.condition,
  });

  static Day fromJson(Map<String, dynamic> json) {
    return Day(
        uv: json['uv'],
        avgtemp_c: json['avgtemp_c'],
        daily_chance_of_rain: json['daily_chance_of_rain'],
        maxtemp_c: json['maxtemp_c'],
        mintemp_c: json['mintemp_c'],
        condition: Condition.fromJson(json['condition']));
  }
}

class Condition {
  String text;

  Condition({required this.text});

  static Condition fromJson(Map<String, dynamic> json) {
    return Condition(text: json['text']);
  }
}

