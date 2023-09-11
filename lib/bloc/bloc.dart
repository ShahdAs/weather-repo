import 'package:bloc/bloc.dart';
import 'package:project/core/api/api.dart';
import '../core/model/current.dart';
import '../core/model/forecast.dart';
part 'event.dart';
part 'state.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  ApiRepo api = ApiRepo();
  HomeBloc() : super(InitState()){
    on((event, emit) async{
      if(event is GetForecast){
        await getMyForecast(event, emit);
      }
      else if(event is AutoCom){
        await autoComplete(event, emit);
      }
      else if(event is GetMyCurrentLocation){
        await getMyCurrent(event, emit);
      }

    });
  }
  Future<void> getMyForecast(GetForecast event,Emitter emit) async{
    emit(LoadingStateGetMyForecast());
    final result = await api.getMyForcast(event.data);
    emit(LoadedStateGetMyForecast(data: result));
  }

  Future<void> autoComplete(AutoCom event, Emitter emit) async{
    emit(LoadingState());
    final result = await api.autoComplete(event.data);
    print(result);
    emit(LoadedStateAutoComplete(data: result));
  }

  Future<void> getMyCurrent(GetMyCurrentLocation event, Emitter emit) async{
    emit(LoadingStateGetMyCurrentLocation());
    final result = await api.getMyCurrentLocation(event.data);
    print(result);
    emit(LoadedStateGetMyCurrentLocation(data: result));
  }
}