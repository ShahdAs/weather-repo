import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../cubit/internet_connection_cubit.dart';

class InternetConnectionCubitListenerLogic {
  dynamic? data;
  InternetConnectionState state;
  Function? internetInitialFunction;
  Function? internetLoadingFunction;
  Function(dynamic?) internetConnectedFunction;
  Function? internetDisconnectedFunction;

  InternetConnectionCubitListenerLogic({
    this.data,
    required this.state,
    Function? internetInitialFunction,
    Function? internetLoadingFunction,
    required this.internetConnectedFunction,
    Function? internetDisconnectedFunction,
  }){main();}

  main() {
    if (state is InternetConnectionConnected) {
      internetConnectedFunction(data);
    } else if (state is InternetConnectionDisconnected) {
      internetDisconnectedFunction;
    } else if (state is InternetConnectionInitial) {
      internetInitialFunction;
    } else if (state is InternetConnectionLoading) {
      internetLoadingFunction;
    } else {
      internetInitialFunction;
    }
  }
}
