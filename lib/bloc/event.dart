part of 'bloc.dart';

abstract class HomeEvent {}

class GetForecast extends HomeEvent {
  final String data;

  GetForecast({required this.data});
}

class AutoCom extends HomeEvent {
  final String data;

  AutoCom({required this.data});
}

class GetMyCurrentLocation extends HomeEvent {
  final String data;

  GetMyCurrentLocation({required this.data});
}
