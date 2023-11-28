import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/bloc/bloc.dart';
import 'package:project/cubit/location_cubit.dart';
import '../cubit/internet_connection_cubit.dart';

class LocationCubitBuilderLogic extends StatelessWidget {
  LocationState state;
  dynamic locationInitialWidget;
  dynamic locationLoadingWidget;
  dynamic locationServiceEnabledWidget;
  dynamic locationServiceDisabledWidget;
  dynamic locationDeniedWidget;

  LocationCubitBuilderLogic(
      {required this.state,
      Widget? locationInitialWidget,
      Widget? locationLoadingWidget,
      Widget? locationServiceEnabledWidget,
      Widget? locationServiceDisabledWidget,
      Widget? locationDeniedWidget,
      Key? key})
      : locationInitialWidget = locationInitialWidget ?? Container(child: null),
        locationLoadingWidget = locationLoadingWidget ??
            const Center(
                child: CircularProgressIndicator(
              color: Colors.white54,
            )),
        locationServiceDisabledWidget =
            locationServiceDisabledWidget ?? Container(child: null),
        locationServiceEnabledWidget =
            locationServiceEnabledWidget ?? Container(child: null),
        locationDeniedWidget = locationDeniedWidget ?? Container(child: null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state is ServiceEnabled) {
      return locationServiceEnabledWidget;
    } else if (state is ServiceDisabled) {
      return locationServiceDisabledWidget;
    } else if (state is LocationDenied || state is LocationDeniedForEver) {
      return locationDeniedWidget;
    } else if (state is LocationLoading) {
      return locationLoadingWidget;
    } else {
      return locationInitialWidget;
    }
  }
}
