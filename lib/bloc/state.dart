part of 'bloc.dart';

class HomeState{
  final BlocStatus myForecast;
  final BlocStatus autoComplete;
  final BlocStatus getExtent;
  final BlocStatus theTimeIndex;
  final BlocStatus getSearchedRegion;

  HomeState({
    this.myForecast = const BlocStatus.initial(),
    this.autoComplete = const BlocStatus.initial(),
    this.getExtent = const BlocStatus.initial(),
    this.theTimeIndex = const BlocStatus.initial(),
    this.getSearchedRegion = const BlocStatus.initial(),
  });

  HomeState copyWith({
    BlocStatus? myForecast,
    BlocStatus? autoComplete,
    BlocStatus? getExtent,
    BlocStatus? theTimeIndex,
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
