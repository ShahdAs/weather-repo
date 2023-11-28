import 'package:flutter/material.dart';
import 'package:project/core/model/bloc_state.dart';

class BlocBuilderLogic extends StatelessWidget {
  Widget successWidget;
  Widget loadingWidget;
  Widget initialWidget;
  Widget errorWidget;
  dynamic state;

  BlocBuilderLogic(
      {required this.state,
      Widget? initialWidget,
      required this.successWidget,
      Widget? loadingWidget,
      Widget? errorWidget,
      Key? key})
      : initialWidget = initialWidget ?? Container(child: null),
        loadingWidget = loadingWidget ??
            const Center(
                child: CircularProgressIndicator(color: Colors.white54)),
        errorWidget = errorWidget ?? Container(child: null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case Status.success:
        return successWidget;
      case Status.initial:
        return initialWidget;
      case Status.loading:
        return loadingWidget;
      case Status.error:
        return errorWidget;
      default:
        return initialWidget;
    }
  }
}
