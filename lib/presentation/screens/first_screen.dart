import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/location_cubit.dart';
import 'package:project/presentation/Widget/getForecastByLocationBottom.dart';
import 'package:project/presentation/Widget/popupDialog.dart';
import 'package:project/presentation/globals.dart';
import '../../logic/LocationCubitBuilder_logic.dart';
import '../Widget/autoComplete_widget.dart';
import '../Widget/getForecastBottom.dart';
import '../Widget/InternetAndLocationState_widget.dart';
import '../Widget/warn_widget.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  const FirstPage._();

  static Page<void> page() => const MaterialPage<void>(child: FirstPage._());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(69, 39, 139, 1),
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              gradient: backGroundGrad,
            ),
            child: Center(
              child: Container(
                height: 250,
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  gradient: backGroundGrad,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    blurRadius: 15,
                  ),
                ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Enter Your Region:",
                      style: font20b,
                    ),
                    const AutoCompleteWidget(),
                    GetForecastBottom(pop: false,),
                    GetForecastByLocationBottom(pop: false),
                    // BlocBuilder<LocationCubit, LocationState>(
                    //     builder: (context, state) {
                    //       if (state is LocationDenied) {
                    //         return Container(child: Text('denied'),);
                    //       }
                    //       else {
                    //         BlocListener<LocationCubit, LocationState>(
                    //           listener: (context, state) {
                    //             if (state is ServiceDisabled) {
                    //               showDialog(
                    //                   context: context,
                    //                   barrierDismissible: true,
                    //                   builder: (BuildContext context) =>
                    //                       PopupDialog(mainWidget: const Text(
                    //                           'Turn Location on!',
                    //                           style: font20l))
                    //               );
                    //             }
                    //             else if (state is ServiceEnabled) {
                    //               print(state.latAndLon);
                    //             }
                    //           },
                    //
                    //         );
                    //         return Container(child: Text('allowed'),);
                    //       }
                    //     })
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}


