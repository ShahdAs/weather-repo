import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/logic/BlocBuilder_logic.dart';
import 'package:project/logic/BlocListener_logic.dart';
import 'package:project/logic/InternetConnectionCubitBuilder_logic.dart';
import 'package:project/logic/InternetConnectionCubitListener_logic.dart';
import 'package:project/presentation/Widget/searchedRegion.dart';
import '../../bloc/bloc.dart';
import '../../cubit/internet_connection_cubit.dart';
import '../globals.dart';
import 'autoComplete_widget.dart';

class GetForecastBottom extends StatelessWidget {
  bool pop;

  GetForecastBottom({required this.pop, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Builder(builder: (context) {
        return SizedBox(
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            return Column(
              children: [
                BlocBuilderLogic(
                  state: state.myForecast,
                  successWidget: ElevatedButtonWidget(pop: pop),
                  initialWidget: ElevatedButtonWidget(pop: pop),
                ),
              ],
            );
          }),
        );
      }),
    );
  }
}

class ElevatedButtonWidget extends StatelessWidget {
  bool pop;

  ElevatedButtonWidget({required this.pop, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () async {
            InternetConnectionCubitListenerLogic(
                state: state,
                data: regionId != null ? "id:${regionId.toString()}" : textEditingController.text,
                internetConnectedFunction: (data) {
                  context
                      .read<HomeBloc>()
                      .add(GetForecast(data: data));
                  if (pop == true) {
                    Navigator.of(context).pop();
                  }
                });
          },
          onLongPress: null,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(28, 27, 51, 0.26)),
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)))),
          child: const SizedBox(
width: 160,
            height: 30,
            child: Center(
              child: Text(
                "Get The Forecast",
                style: font20,
              ),
            ),
          ),
        );
      },
    );
  }
}