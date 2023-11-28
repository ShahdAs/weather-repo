import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/bloc/bloc.dart';
import 'package:project/logic/BlocBuilder_logic.dart';
import 'package:project/presentation/screens/first_screen.dart';
import 'package:project/presentation/screens/home_screen.dart';
import 'package:project/presentation/screens/loading_screen.dart';

import '../Widget/InternetAndLocationState_widget.dart';

class Node extends StatelessWidget {
  // const Node._();
  // static Page<void> page() => const MaterialPage<void>(child: Node._());
  const Node({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return BlocBuilderLogic(
              state: state.myForecast,
              initialWidget: const FirstPage(),
              loadingWidget: const LoadingPage(),
              successWidget: HomePage(),
              errorWidget: const FirstPage(),
            );
          },
        ),
        const Positioned(
          top: 0,
          left: 0,
          child: Column(
            children: [
              InternetStateWidget(),
              LocationStateWidget()
            ],
          ),
        )
      ],
    );
  }
}


// builder: (context, state){
// if (state.myForecast.isInitial()) {
// return const FirstPage();
// } else if (state.myForecast.isLoading()) {
// return const LoadingPage();
// } else if (state.myForecast.isSuccess()) {
// return const HomePage();
// } else {
// return const FirstPage();
// }
// }
