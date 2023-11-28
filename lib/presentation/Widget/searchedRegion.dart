import 'package:equatable/equatable.dart';

class SearchedRegionList{
  List<SearchedRegion> searchedRegionList;
  SearchedRegionList({required this.searchedRegionList});

  Map<String, dynamic> toMap() {
    return {
      'searchedRegionList': searchedRegionList.map((e) => e.toMap()).toList(),
    };
  }

  factory SearchedRegionList.fromMap(Map<String, dynamic> map) {
    return SearchedRegionList(
      searchedRegionList: (map['searchedRegionList'] as List)
          .map((e) => SearchedRegion.fromMap(e))
          .toList(),
    );
  }
}

class SearchedRegion extends Equatable{
  final String name;
  final String region;
  final String country;
  final double lon;
  final double lat;

  SearchedRegion(
      {required this.name,
      required this.region,
      required this.country,
      required this.lon,
      required this.lat});

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'region': this.region,
      'country': this.country,
      'lon': this.lon,
      'lat': this.lat,
    };
  }

  factory SearchedRegion.fromMap(Map<String, dynamic> map) {
    return SearchedRegion(
      name: map['name'] as String,
      region: map['region'] as String,
      country: map['country'] as String,
      lon: map['lon'] as double,
      lat: map['lat'] as double,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is SearchedRegion &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          region == other.region &&
          country == other.country &&
          lon == other.lon &&
          lat == other.lat;

  @override
  int get hashCode =>
      super.hashCode ^
      name.hashCode ^
      region.hashCode ^
      country.hashCode ^
      lon.hashCode ^
      lat.hashCode;

  @override
  List<Object?> get props => [name, region, country, lon, lat];
}
