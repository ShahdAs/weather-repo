import 'dart:convert';
import 'package:project/presentation/Widget/searchedRegion.dart';
import 'package:project/sharedPreference/sharedPreference_get.dart';
import 'package:shared_preferences/shared_preferences.dart';


enum Save {add, delete}
class SavePrefs{
  Save save;
  SearchedRegion givedData;
  late List<SearchedRegion>? data;
  SavePrefs({ required this.givedData, required this.save}){main();}

  main() async {
    data = await GetPrefs.get();
      if(save == Save.add){
        if(!data!.contains(givedData)){
          data?.add(givedData);
          SearchedRegionList searchedRegionList = SearchedRegionList(searchedRegionList: data!);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Map<String, dynamic> map = searchedRegionList.toMap();
          String dataString = jsonEncode(map);
          prefs.setString('SearchedRegionList', dataString);
          print('data is saved in shared prefrences');
        }
      }
      if(save == Save.delete){
        if(data!.contains(givedData)){
          data?.remove(givedData);
          SearchedRegionList searchedRegionList = SearchedRegionList(searchedRegionList: data!);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Map<String, dynamic> map = searchedRegionList.toMap();
          String dataString = jsonEncode(map);
          prefs.setString('SearchedRegionList', dataString);
          print('data is saved in shared prefrences');
        }
      }
  }
}