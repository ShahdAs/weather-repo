import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bloc.dart';
import '../../cubit/internet_connection_cubit.dart';
import '../globals.dart';
import 'autoComplete_widget.dart';

Widget getForecastBottom(bool pop) {
  return SizedBox(
    height: 70,
    child: Builder(builder: (context) {
      return BlocProvider(
        create: (context) =>
        InternetConnectionCubit()
          ..checkConnection(),
        child: SizedBox(
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            return Column(
              children: [
                state.myForecast.isSuccess()
                    ? elevatedButton(pop)
                    : state.myForecast.isLoading()
                    ? const CircularProgressIndicator(
                  color: Colors.white54,
                )
                    : elevatedButton(pop),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<InternetConnectionCubit, InternetConnectionState>(builder: (context, state){
                  if(state is InternetConnectionDisconnected){
                    return const Text(
                      "there is no internet connection",
                      style: font20red,
                    );
                  }else{
                    return Container(child: null,);
                  }
                })
              ],
            );
          }),
        ),
      );
    }),
  );
}

Widget elevatedButton(bool pop) {
  return Builder(builder: (context) {
    return BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
  builder: (context, state) {
    return ElevatedButton(
      onPressed: () async {
        if (state is InternetConnectionConnected) {
          context.read<HomeBloc>()
            ..add(GetForecast(data: textEditingController.text))..add(GetExtant(data: 0.4));
          if(pop == true){
            Navigator.of(context).pop();
          }
        } else {
          null;
        }
      },
      onLongPress: null,
      style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all(const Color.fromRGBO(28, 27, 51, 0.26)),
          padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)))),
      child:const Text(
        "Get The Forecast",
        style: font20,
      ),
    );
  },
);
  });
}
