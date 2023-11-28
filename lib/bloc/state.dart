part of 'bloc.dart';

class HomeState{
  final BlocStatus myForecast;
  final BlocStatus autoComplete;
  final double getExtent;
  final List<int> theTimeIndex;
  final BlocStatus getSearchedRegion;

  HomeState({
    this.myForecast = const BlocStatus.initial(),
    this.autoComplete = const BlocStatus.initial(),
    this.getExtent = 0.4,
    this.theTimeIndex = const [0,0],
    this.getSearchedRegion = const BlocStatus.initial(),
  });

  HomeState copyWith({
    BlocStatus? myForecast,
    BlocStatus? autoComplete,
    double? getExtent,
    List<int>? theTimeIndex,
    BlocStatus? getSearchedRegion,
  }) {
    return HomeState(
      myForecast: myForecast ?? this.myForecast,
      autoComplete: autoComplete ?? this.autoComplete,
      getExtent: getExtent ?? this.getExtent,
      theTimeIndex: theTimeIndex ?? this.theTimeIndex,
      getSearchedRegion: getSearchedRegion ?? this.getSearchedRegion
    );
  }


}
