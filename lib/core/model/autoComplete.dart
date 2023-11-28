class AutoComplete {
  String name;
  String region;
  String country;
  int id;

  AutoComplete(
      {required this.id,required this.name, required this.region, required this.country});

  static AutoComplete fromJson(Map<String, dynamic> json) {
    return AutoComplete(
        id: json['id'], name: json["name"], country: json["country"], region: json["region"]);
  }
}