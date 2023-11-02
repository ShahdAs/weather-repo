import 'package:flutter/material.dart';
import 'package:project/presentation/globals.dart';
import '../Widget/autoComplete_widget.dart';
import '../Widget/getForecastBottom.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);
  const FirstScreen._();

  static Page<void> page() => const MaterialPage<void>(child: FirstScreen._());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(69, 39, 139, 1),
      body: Stack(
        children: [

          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
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
                  const AutoCompleteWidget(),
                  getForecastBottom(false)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


