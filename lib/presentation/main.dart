import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/bloc/bloc.dart';
import 'package:project/presentation/router/app_router.dart';
import 'package:project/provider/myProvider.dart';
import 'package:project/presentation/screens/first_screen.dart';
import 'package:project/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main(){
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter =AppRouter();
   // const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(),
      child: ChangeNotifierProvider(
        create: (_)=> MyProvider(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
          onGenerateRoute: _appRouter.onGenerateRoute,
        ),
      ),
    );
  }


}