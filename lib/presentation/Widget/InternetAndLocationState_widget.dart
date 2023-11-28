import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/location_cubit.dart';
import 'package:project/logic/LocationCubitBuilder_logic.dart';
import '../../cubit/internet_connection_cubit.dart';
import '../../logic/InternetConnectionCubitBuilder_logic.dart';
import 'warn_widget.dart';

class InternetStateWidget extends StatelessWidget {
  const InternetStateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
      builder: (context, internetState) {
        return InternetConnectionCubitBuilderLogic(
          state: internetState,
          internetConnectedWidget: WarningWidget(start: true,
              error: Warn.green,
              content: 'Internet Connected'),
          internetDisconnectedWidget: WarningWidget(start: true,
              error: Warn.black,
              content: 'There is no internet Connection'),
        );
      },
    );
  }
}

class LocationStateWidget extends StatelessWidget {
  const LocationStateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
        builder: (context, locationState){
          return LocationCubitBuilderLogic(
            state: locationState,
            locationDeniedWidget: WarningWidget(start: true, error: Warn.orange,content: 'location permission is denied!'),
            locationServiceDisabledWidget: WarningWidget(start: true, error: Warn.orange,content: 'Pleas turn on your Location'),
          );
        });
  }
}




