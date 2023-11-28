import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/bloc/bloc.dart';
import '../cubit/internet_connection_cubit.dart';

class InternetConnectionCubitBuilderLogic extends StatelessWidget {
  InternetConnectionState state;
  dynamic internetInitialWidget;
  dynamic internetLoadingWidget;
  dynamic internetConnectedWidget;
  dynamic internetDisconnectedWidget;

  InternetConnectionCubitBuilderLogic(
      {required this.state,
      Widget? internetInitialWidget,
      Widget? internetLoadingWidget,
      required this.internetConnectedWidget,
      required this.internetDisconnectedWidget,
      Key? key})
      : internetInitialWidget = internetInitialWidget ?? Container(child: null),
        internetLoadingWidget = internetLoadingWidget ??
            const Center(
                child: CircularProgressIndicator(
              color: Colors.white54,
            )),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if(state is InternetConnectionConnected){
      return internetConnectedWidget;
    } else if(state is InternetConnectionDisconnected){
      return internetDisconnectedWidget;
    }else if (state is InternetConnectionInitial) {
      return internetInitialWidget;
    } else if (state is InternetConnectionLoading) {
      return internetLoadingWidget;
    } else {
      return internetInitialWidget;
    }
  }
}
