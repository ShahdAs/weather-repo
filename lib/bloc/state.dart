part of 'bloc.dart';


 class HomeState{
  final BlocStatus myForecast;
  final BlocStatus autoComplete;
  final BlocStatus myCurrent;

  HomeState({
    this.myForecast = const BlocStatus.initial(),
    this.autoComplete = const BlocStatus.initial(),
    this.myCurrent = const BlocStatus.initial(),
 });

  HomeState copyWith({BlocStatus? myForecast,BlocStatus? autoComplete,BlocStatus? myCurrent}){
    return HomeState(
      myForecast: myForecast ?? this.myForecast,
      autoComplete: autoComplete ?? this.autoComplete,
      myCurrent: myCurrent ?? this.myCurrent,
    );
  }

}

