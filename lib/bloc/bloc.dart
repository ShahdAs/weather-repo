import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:project/core/api/api.dart';
import 'package:project/sharedPreference/sharedPreference_get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/model/bloc_state.dart';
import 'dart:io';

import '../core/model/forecast.dart';
import '../presentation/Widget/searchedRegion.dart';
import '../sharedPreference/sharedPreference_save.dart';

part 'event.dart';

part 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ApiRepo api = ApiRepo();

  HomeBloc() : super(HomeState()) {
    on((event, emit) async {
      if (event is GetForecast) {
        await getMyForecast(event, emit);
      } else if (event is AutoCom) {
        await autoComplete(event, emit);
      } else if (event is GetExtant) {
        await getExtent(event, emit);
      } else if (event is TheTimeIndex) {
        await theTimeIndex(event, emit);
      } else if (event is GetSearchedRegion) {
        await getSearchedRegion(event, emit);
      }
    });
  }

  getSearchedRegion(GetSearchedRegion event, Emitter emit) async {
    emit(state.copyWith(getSearchedRegion: const BlocStatus.loading()));
     if (event.data != null) {
      emit(state.copyWith(getSearchedRegion: BlocStatus.success(event.data)));
     }
    // else if(event.data == null){
    //   emit(state.copyWith(getSearchedRegion: const BlocStatus.loading()));
    //   List<SearchedRegion> data = await GetPrefs.get();
    //   emit(state.copyWith(getSearchedRegion: BlocStatus.success(data)));
    // }else{
    //   emit(state.copyWith(getSearchedRegion: const BlocStatus.error()));
    // }
  }

  Future<void> getMyForecast(GetForecast event, Emitter emit) async {
    emit(state.copyWith(myForecast: const BlocStatus.loading()));

    try {
      final result = await api.getMyForecast(event.data);
      emit(state.copyWith(myForecast: BlocStatus.success(result)));
      savePrefs(result);
      SavePrefs(
          save: Save.add,
          givedData: SearchedRegion(
              name: state.myForecast.data.locationModel.name,
              region: state.myForecast.data.locationModel.region,
              country: state.myForecast.data.locationModel.country,
              lon: state.myForecast.data.locationModel.lon,
              lat: state.myForecast.data.locationModel.lat));

      print('connected forecast');
      // }
    } on SocketException catch (_) {
      emit(state.copyWith(myForecast: const BlocStatus.error()));
    }
  }

  Future<void> autoComplete(AutoCom event, Emitter emit) async {
    try {
      emit(state.copyWith(autoComplete: const BlocStatus.loading()));
      final result = await api.autoComplete(event.data);
      if (result != null) {
        emit(state.copyWith(autoComplete: BlocStatus.success(result)));
        print('connected');
      }
    } on SocketException catch (_) {
      emit(state.copyWith(autoComplete: const BlocStatus.error()));
      print('not connected');
    }
  }

  getExtent(GetExtant event, Emitter emit) {
    emit(state.copyWith(getExtent: event.data));
  }

  theTimeIndex(TheTimeIndex event, Emitter emit) {
    emit(state.copyWith(theTimeIndex: event.data));
  }
}

savePrefs(Forecast data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Forecast forecast = Forecast(
      locationModel: data.locationModel,
      currentModel: data.currentModel,
      forecastModel: data.forecastModel);
  Map<String, dynamic> map = forecast.toMap();
  String dataString = jsonEncode(map);
  prefs.setString('forecast', dataString);
  print('data is saved in shared prefrences');
}
