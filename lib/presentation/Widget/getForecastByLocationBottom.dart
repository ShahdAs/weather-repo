import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/location_cubit.dart';
import 'package:project/logic/BlocBuilder_logic.dart';
import 'package:project/logic/BlocListener_logic.dart';
import 'package:project/logic/InternetConnectionCubitBuilder_logic.dart';
import 'package:project/logic/InternetConnectionCubitListener_logic.dart';
import 'package:project/logic/LocationCubitListener_logic.dart';
import 'package:project/presentation/Widget/warn_widget.dart';
import 'package:project/presentation/Widget/searchedRegion.dart';
import '../../bloc/bloc.dart';
import '../../cubit/internet_connection_cubit.dart';
import '../globals.dart';
import 'autoComplete_widget.dart';

class GetForecastByLocationBottom extends StatelessWidget {
  bool pop;

  GetForecastByLocationBottom({required this.pop, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Builder(builder: (context) {
        return SizedBox(
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            return Column(
              children: [
                BlocBuilderLogic(
                  state: state.myForecast,
                  successWidget: TextButtonWidget(pop: pop),
                  initialWidget: TextButtonWidget(pop: pop),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            );
          }),
        );
      }),
    );
  }
}

class TextButtonWidget extends StatelessWidget {
  bool pop;

  TextButtonWidget({required this.pop, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, locationState) {
        return BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
          builder: (context, internetState) {
            return TextButton(
              onPressed: () async {
                if (locationState is ServiceEnabled) {
                  String? data = locationState.latAndLon;
                  InternetConnectionCubitListenerLogic(
                      state: internetState,
                      data: data,
                      internetConnectedFunction: (data) {
                        context
                            .read<HomeBloc>()
                            .add(GetForecast(data: data));
                        if (pop == true) {
                          Navigator.of(context).pop();
                        }
                      });
                } else if(locationState is ServiceDisabled || locationState is LocationDenied || locationState is LocationDeniedForEver){
                  context.read<LocationCubit>().checkLocation();
                }
              },
              onLongPress: null,
              child: const Text(
                "Get The Forecast By Location",
                style: font20,
              ),
            );
          },
        );
      },
    );
  }
}
