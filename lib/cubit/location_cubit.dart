
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());


  void checkLocation() async{
    bool service;
    service = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }
    else if(permission == LocationPermission.always || permission == LocationPermission.whileInUse){
      if(service == true){
        String data = await getLatAndLon();
        emit(ServiceEnabled(latAndLon: data));
        print('ll   ' + data);
      }
      else if(service == false){
        emit(ServiceDisabled());
      }
    }
    else if(permission == LocationPermission.deniedForever){
      emit(LocationDeniedForEver());
    }
  }

  Future<String> getLatAndLon() async{
    Position pos = await Geolocator.getCurrentPosition();
    return '${pos.latitude.toStringAsFixed(2)},${pos.longitude.toStringAsFixed(2)}';
  }
  @override
  Future<void> close(){
    return super.close();
  }
}
