import 'package:bloc/bloc.dart';
import 'package:project/core/api/api.dart';
import '../core/model/bloc_state.dart';
import '../core/model/current.dart';
import '../core/model/forecast.dart';
part 'event.dart';
part 'state.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  ApiRepo api = ApiRepo();
  HomeBloc() : super(HomeState()){
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
    emit(state.copyWith(myForecast: const BlocStatus.initial()));
    final result = await api.getMyForcast(event.data);
    emit(state.copyWith(myForecast: BlocStatus.success(result)));
  }

  Future<void> autoComplete(AutoCom event, Emitter emit) async{
    emit(state.copyWith(autoComplete: const BlocStatus.initial()));
    final result = await api.autoComplete(event.data);
    print(result);
    emit(state.copyWith(autoComplete: BlocStatus.success(result)));
  }

  Future<void> getMyCurrent(GetMyCurrentLocation event, Emitter emit) async{
    emit(state.copyWith(myCurrent: const BlocStatus.initial()));

    final result = await api.getMyCurrentLocation(event.data);
    print(result);
    emit(state.copyWith(myCurrent: BlocStatus.success(result)));
  }
}