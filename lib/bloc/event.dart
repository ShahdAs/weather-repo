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


class GetExtant extends HomeEvent{
  final double data;
  GetExtant({
    required this.data
});
}

class TheTimeIndex extends HomeEvent{
  final List<int> data;
  TheTimeIndex({
    required this.data
  });
}

class GetSearchedRegion extends HomeEvent{
  final List<SearchedRegion> data;

  GetSearchedRegion({required this.data});
}


