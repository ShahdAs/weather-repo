import 'package:project/core/model/bloc_state.dart';

class BlocListenerLogic {
  BlocStatus state;
  dynamic? data;
  Function(dynamic?) successFunction;
  Function(dynamic?) loadingFunction;
  Function initialFunction;
  Function errorFunction;

  BlocListenerLogic({
    required this.state,
    this.data,
    required this.initialFunction,
    required this.successFunction,
    required this.loadingFunction,
    required this.errorFunction,
  }){
    main();
  }

  main(){
    switch (state.status) {
      case Status.success:
        loadingFunction;
        successFunction(data);
      case Status.initial:
        initialFunction;
      case Status.loading:
        loadingFunction(data);
      case Status.error:
        errorFunction;
    }
  }
}
