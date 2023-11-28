import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/bloc/bloc.dart';
import 'package:project/cubit/location_cubit.dart';
import 'package:project/presentation/router/app_router.dart';
import 'package:project/presentation/router/flow_builder_router.dart';

import 'cubit/internet_connection_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  // const MyApp({super.key})0;
  @override
  Widget build(BuildContext context) {
    // return BlocProvider<HomeBloc>(
    //   create: (context) => HomeBloc(),
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     onGenerateRoute: _appRouter.onGenerateRoute,
    //     initialRoute: '/node',
    //   ),
    //   // ),
    // );
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider<InternetConnectionCubit>(
          create: (context) => InternetConnectionCubit()..checkConnection(),
        ),
        BlocProvider<LocationCubit>(
          create: (context) => LocationCubit()..checkLocation(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: _appRouter.onGenerateRoute,
        initialRoute: '/splash_screen',
      ),
    );
  }
}
