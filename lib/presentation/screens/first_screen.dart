import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/bloc/bloc.dart';
import 'package:project/core/model/bloc_state.dart';
import 'package:project/presentation/globals.dart';
import '../Widget/autoComplete_widget.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Global global = Global.getInstance();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(69, 39, 139, 1),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: backGroundGrad,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 200,
              decoration: const BoxDecoration(
                gradient: bottomSheetGrad,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Enter Your Region:",
                    style: font20b,
                  ),
                  AutoCompleteWidget(),
                  BlocSelector<HomeBloc, HomeState, BlocStatus>(
                    selector: (state) => state.myForecast,
                    builder: (context, state2) {
                      return BlocSelector<HomeBloc, HomeState, BlocStatus>(
                        selector: (state) => state.myCurrent,
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              if (state.isSuccess() && state2.isSuccess()) {
                                global.myCurrentVar = state.data;
                                global.myForecastVar = state2.data;
                                context
                                    .read<HomeBloc>()
                                    .add(GetExtant(data: 0.4));
                                Navigator.pushNamed(context, '/');
                              } else {
                                null;
                              }
                            },
                            onLongPress: null,
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(28, 27, 51, 0.26)),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(10)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)))),
                            child: state.isLoading()
                                ? CircularProgressIndicator(color: Colors.white60,)
                                : state2.isLoading()
                                    ? CircularProgressIndicator(color: Colors.white60,)
                                    : state.isInitial()
                                        ? null
                                        : state2.isInitial()
                                            ? null
                                            : const Text(
                                                "Get the Forecast",
                                                style: font20,
                                              ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
