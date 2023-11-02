// import 'package:flow_builder/flow_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:project/core/model/bloc_state.dart';
// import 'package:project/presentation/screens/loading_screen.dart';
// import 'package:project/presentation/screens/searchedRegion_screen.dart';
//
// import '../../bloc/bloc.dart';
// import '../screens/first_screen.dart';
// import '../screens/home_screen.dart';
//
// class AuthenticationFlow extends StatelessWidget {
//   const AuthenticationFlow({super.key});
//
//
//
//   static Route<BlocStatus> route() {
//     return MaterialPageRoute(
//       builder: (_) => const AuthenticationFlow(),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FlowBuilder<Status>(
//       state: context.select((HomeBloc bloc) => bloc.state.myForecast.status),
//       onGeneratePages: (Status state, List<Page<dynamic>> pages) {
//         switch (state) {
//           case Status.success:
//             return [HomePage.page()];
//           case Status.loading:
//             return[LoadingPage.page()];
//           default:
//             return [FirstScreen.page()];
//         }
//       },
//     );
//   }
// }
