import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../cubit/internet_connection_cubit.dart';
import '../cubit/location_cubit.dart';

class LocationCubitListenerLogic {

  LocationState state;
  dynamic? data;
  Function? locationInitialFunction;
  Function? locationLoadingFunction;
  Function(dynamic?) locationServiceEnabledFunction;
  Function? locationServiceDisabledFunction;
  Function? locationDeniedFunction;

  LocationCubitListenerLogic(
      {required this.state,
        this.data,
        Function? locationInitialFunction,
        Function? locationLoadingFunction,
        required this.locationServiceEnabledFunction,
        Function? locationServiceDisabledFunction,
        Function? locationDeniedFunction}){main();}

  main() {
    if (state is ServiceEnabled) {
      locationServiceEnabledFunction!(data);
    } else if (state is ServiceDisabled) {
      locationServiceDisabledFunction;
    } else if (state is LocationDenied || state is LocationDeniedForEver) {
      locationDeniedFunction;
    } else if (state is LocationLoading) {
      locationLoadingFunction;
    } else {
      locationInitialFunction;
    }
  }
}
