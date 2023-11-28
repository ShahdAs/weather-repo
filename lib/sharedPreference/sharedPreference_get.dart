import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/Widget/searchedRegion.dart';

class GetPrefs {
  GetPrefs() {
    get();
  }

  static Future<List<SearchedRegion>> get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dataString = prefs.getString('SearchedRegionList');
    if (dataString == null) {
      return [];
    } else {
      Map<String, dynamic> map = jsonDecode(dataString!);
      SearchedRegionList list = SearchedRegionList.fromMap(map);
      List<SearchedRegion> data = list.searchedRegionList;
      return data;
    }
  }
}
