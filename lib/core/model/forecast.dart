class Forcast {
  double avgtemp_c;
  int daily_chance_of_rain;
  double maxtemp_c;
  double mintemp_c;
  Condition condition;

  Forcast({
    required this.avgtemp_c,
    required this.daily_chance_of_rain,
    required this.maxtemp_c,
    required this.mintemp_c,
    required this.condition,
  });

 static Forcast fromJson(Map<String, dynamic> json) {
    return Forcast(avgtemp_c: json['avgtemp_c'],
        daily_chance_of_rain: json['daily_chance_of_rain'],
        maxtemp_c: json['maxtemp_c'],
        mintemp_c: json['mintemp_c'],
        condition: Condition.fromJson(json['condition']));
  }

}


class Condition {
  String text;

  Condition({
    required this.text
  });

  static Condition fromJson(Map<String, dynamic> json) {
    return Condition(text: json['text']);
  }


}

class CurrentLocation{

}