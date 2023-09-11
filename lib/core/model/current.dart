

class CurrentModel{
  final int last_updated_epoch;
  final double temp_c;

  CurrentModel({
    required this.last_updated_epoch,
    required this.temp_c
});


  static CurrentModel fromMap(Map<String,dynamic> json){
    return CurrentModel(
        last_updated_epoch: json["last_updated_epoch"],
        temp_c: json["temp_c"]);
  }
}