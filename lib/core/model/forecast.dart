class Forecast {
  final LocationModel locationModel;
  final CurrentModel currentModel;
  final List<ForecastModel> forecastModel;

  Forecast(
      {required this.locationModel,
      required this.currentModel,
      required this.forecastModel});

  static Forecast fromJson(Map<String, dynamic> json) {
    return Forecast(
        locationModel: LocationModel.fromJson(json['location']),
        currentModel: CurrentModel.fromJson(json['current']),
        forecastModel: (json['forecast']['forecastday'] as List)
            .map((e) => ForecastModel.fromJson(e))
            .toList());
  }

  Map<String, dynamic> toMap() {
    return {
      'locationModel': locationModel.toMap(),
      'currentModel': currentModel.toMap(),
      'forecastModel': forecastModel.map((e) => e.toMap()).toList(),
    };
  }

  factory Forecast.fromMap(Map<String, dynamic> map) {
    return Forecast(
      locationModel: LocationModel.fromMap(map['locationModel']),
      currentModel: CurrentModel.fromMap(map['currentModel']),
      forecastModel: (map['forecastModel'] as List)
          .map((e) => ForecastModel.fromMap(map[e]))
          .toList(),
    );
  }
}

class LocationModel {
  final String name;
  final String region;
  final String country;
  final double lon;
  final double lat;

  LocationModel(
      {required this.name, required this.country, required this.region, required this.lat, required this.lon});

  static LocationModel fromJson(Map<String, dynamic> json) {
    return LocationModel(
        name: json["name"], country: json["country"], region: json["region"], lon: json['lon'], lat: json['lat']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'region': region,
      'country': country,
      'lon': lon,
      'lat': lat
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      name: map['name'] as String,
      region: map['region'] as String,
      country: map['country'] as String,
      lat: map['lat'] as double,
      lon: map['lon'] as double
    );
  }
}

class CurrentModel {
  final int last_updated_epoch;
  final double temp_c;
  final Condition condition;
  final double uv;
  final AirQuality airQuality;
  final double wind_kph;
  final double vis_km;
  final double pressure_in;
  final double feelslike_c;
  final int humidity;

  CurrentModel(
      {required this.last_updated_epoch,
      required this.temp_c,
      required this.condition,
      required this.uv,
      required this.airQuality,
      required this.wind_kph,
      required this.feelslike_c,
      required this.humidity,
      required this.pressure_in,
      required this.vis_km});

  static CurrentModel fromJson(Map<String, dynamic> json) {
    return CurrentModel(
        airQuality: AirQuality.fromJson(json["air_quality"]),
        last_updated_epoch: json["last_updated_epoch"],
        uv: json['uv'],
        temp_c: json["temp_c"],
        condition: Condition.fromJson(json['condition']),
        wind_kph: json['wind_kph'],
        feelslike_c: json['feelslike_c'],
        humidity: json['humidity'],
        pressure_in: json['pressure_in'],
        vis_km: json['vis_km']);
  }

  Map<String, dynamic> toMap() {
    return {
      'last_updated_epoch': #last_updated_epoch,
      'temp_c': temp_c,
      'condition': condition.toMap(),
      'uv': uv,
      'airQuality': airQuality.toMap(),
      'wind_kph': wind_kph,
      'vis_km': vis_km,
      'pressure_in': pressure_in,
      'feelslike_c': feelslike_c,
      'humidity': humidity,
    };
  }

  factory CurrentModel.fromMap(Map<String, dynamic> map) {
    return CurrentModel(
      last_updated_epoch: map['last_updated_epoch'] as int,
      temp_c: map['temp_c'] as double,
      condition: Condition.fromMap(map['condition']),
      uv: map['uv'] as double,
      airQuality: AirQuality.fromMap(map['airQuality']),
      wind_kph: map['wind_kph'] as double,
      vis_km: map['vis_km'] as double,
      pressure_in: map['pressure_in'] as double,
      feelslike_c: map['feelslike_c'] as double,
      humidity: map['humidity'] as int,
    );
  }
}

class AirQuality {
  int? gbdefraindex;

  AirQuality({required this.gbdefraindex});

  static AirQuality fromJson(Map<String, dynamic> json) {
    return AirQuality(gbdefraindex: json["gb-defra-index"]);
  }

  Map<String, dynamic> toMap() {
    return {
      'gbdefraindex': this.gbdefraindex,
    };
  }

  factory AirQuality.fromMap(Map<String, dynamic> map) {
    return AirQuality(
      gbdefraindex: map['gbdefraindex'] as int,
    );
  }
}

class Condition {
  String text;
  String icon;

  Condition({required this.text, required this.icon});

  static Condition fromJson(Map<String, dynamic> json) {
    return Condition(text: json['text'], icon: json['icon']);
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'icon': icon,
    };
  }

  factory Condition.fromMap(Map<String, dynamic> map) {
    return Condition(
      text: map['text'] as String,
      icon: map['icon'] as String,
    );
  }
}

class ForecastModel {
  String date;
  Day day;
  Astro astro;
  List<Hour> hour;

  ForecastModel(
      {required this.day,
      required this.astro,
      required this.hour,
      required this.date});

  static ForecastModel fromJson(Map<String, dynamic> json) {
    return ForecastModel(
        date: json['date'],
        day: Day.fromJson(json['day']),
        astro: Astro.fromJson(json['astro']),
        hour: (json['hour'] as List).map((e) => Hour.fromJson(e)).toList());
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'day': day.toMap(),
      'astro': astro.toMap(),
      'hour': hour.map((e) => e.toMap()).toList(),
    };
  }

  factory ForecastModel.fromMap(Map<String, dynamic> map) {
    return ForecastModel(
      date: map['date'] as String,
      day: Day.fromMap(map['day']),
      astro: Astro.fromMap(map['astro']),
      hour: (map['hour'] as List).map((e) => Hour.fromMap(map[e])).toList(),
    );
  }
}

class Astro {
  String sunset;
  String sunrise;

  Astro({required this.sunrise, required this.sunset});

  static Astro fromJson(Map<String, dynamic> json) {
    return Astro(sunrise: json['sunrise'], sunset: json['sunset']);
  }

  Map<String, dynamic> toMap() {
    return {
      'sunset': sunset,
      'sunrise': sunrise,
    };
  }

  factory Astro.fromMap(Map<String, dynamic> map) {
    return Astro(
      sunset: map['sunset'] as String,
      sunrise: map['sunrise'] as String,
    );
  }
}

class Hour {
  String time;
  int chance_of_rain;
  Condition condition;
  double temp_c;
  double dewpoint_c;

  Hour(
      {required this.condition,
      required this.temp_c,
      required this.chance_of_rain,
      required this.time,
      required this.dewpoint_c});

  static Hour fromJson(Map<String, dynamic> json) {
    return Hour(
        condition: Condition.fromMap(json['condition']),
        temp_c: json['temp_c'],
        chance_of_rain: json['chance_of_rain'],
        time: json['time'],
        dewpoint_c: json['dewpoint_c']);
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'chance_of_rain': chance_of_rain,
      'condition': condition.toMap(),
      'temp_c': temp_c,
      'dewpoint_c': dewpoint_c,
    };
  }

  factory Hour.fromMap(Map<String, dynamic> map) {
    return Hour(
      time: map['time'] as String,
      chance_of_rain: map['chance_of_rain'] as int,
      condition: Condition.fromMap(map['condition']),
      temp_c: map['temp_c'] as double,
      dewpoint_c: map['dewpoint_c'] as double,
    );
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
        condition: Condition.fromMap(json['condition']));
  }

  Map<String, dynamic> toMap() {
    return {
      'uv': uv,
      'avgtemp_c': avgtemp_c,
      'daily_chance_of_rain': daily_chance_of_rain,
      'maxtemp_c': maxtemp_c,
      'mintemp_c': mintemp_c,
      'condition': condition.toMap(),
    };
  }

  factory Day.fromMap(Map<String, dynamic> map) {
    return Day(
      uv: map['uv'] as double,
      avgtemp_c: map['avgtemp_c'] as double,
      daily_chance_of_rain: map['daily_chance_of_rain'] as int,
      maxtemp_c: map['maxtemp_c'] as double,
      mintemp_c: map['mintemp_c'] as double,
      condition: Condition.fromMap(map['condition']),
    );
  }
}
