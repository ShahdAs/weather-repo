part of 'bloc.dart';


abstract class HomeState{
}



class InitState extends HomeState{


}

class LoadingState extends HomeState{

}

class LoadingStateGetMyForecast extends HomeState{

}
class LoadingStateGetMyCurrentLocation extends HomeState{

}


class LoadedStateGetMyForecast extends HomeState{
  final List<Forcast> data;
  LoadedStateGetMyForecast({
    required this.data
});
}
class LoadedStateAutoComplete extends HomeState{
  final List<String> data;
  LoadedStateAutoComplete({required this.data});
}
 class LoadedStateGetMyCurrentLocation extends HomeState{
  final CurrentModel data;
  LoadedStateGetMyCurrentLocation({required this.data});
 }
