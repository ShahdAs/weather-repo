import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';
import 'dart:async';

part 'internet_connection_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  StreamSubscription? _streamSubscription;
  InternetConnectionCubit() : super(InternetConnectionInitial());

  void checkConnection(){
    _streamSubscription  = InternetConnectionChecker().onStatusChange.listen((event) {
      if(event == InternetConnectionStatus.connected){
        emit(InternetConnectionConnected());
      }else{
        emit(InternetConnectionDisconnected());
      }
    });

  }

  @override
  Future<void> close(){
    _streamSubscription!.cancel();
    return super.close();

  }
}


