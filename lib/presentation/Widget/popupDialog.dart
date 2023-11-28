import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../globals.dart';

class PopupDialog extends StatelessWidget {
  Widget mainWidget;
  String actionName;
  void Function()? action;

  PopupDialog(
      {required this.mainWidget, String? actionName, required this.action, Key? key})
      :actionName = actionName ?? "",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Container(
        decoration: const BoxDecoration(
            gradient: backGroundGrad,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: SizedBox(
          height: 223,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:  CrossAxisAlignment.center,
            children: [
              mainWidget,
              Padding(

                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextButton(
                          onPressed: action,
                          child: Text(actionName, style: font20b)),
                    ),Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Close", style: font20l)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
