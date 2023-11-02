import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/bloc/bloc.dart';
import 'package:project/presentation/screens/first_screen.dart';
import 'package:project/presentation/screens/home_screen.dart';
import 'package:project/presentation/screens/loading_screen.dart';

class Node extends StatelessWidget {
  // const Node._();
  // static Page<void> page() => const MaterialPage<void>(child: Node._());
  const Node({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state){
          if(state.myForecast.isInitial()){
            return const FirstScreen();
          }else if(state.myForecast.isLoading()){
            return const LoadingPage();
          }else if(state.myForecast.isSuccess()){
            return HomePage();
          }else{
            return const FirstScreen();
          }
        }
    );
  }
}
