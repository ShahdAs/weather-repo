part of 'location_cubit.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}
class LocationLoading extends LocationState{}
class LocationDenied extends LocationState {}
class LocationDeniedForEver extends LocationState {}
class LocationAllowed extends LocationState {}
class ServiceDisabled extends LocationState {}
class ServiceEnabled extends LocationState {
  String? latAndLon;
  ServiceEnabled({this.latAndLon});


}
