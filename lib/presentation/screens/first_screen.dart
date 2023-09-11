import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/presentation/globals.dart';
import 'package:provider/provider.dart';
import '../../provider/myProvider.dart';
import '../Widget/autoComplete_widget.dart';

class FirstScreen extends StatelessWidget {
  FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String x =
        Provider.of<MyProvider>(context, listen: true).autoCompleteValueA;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(69, 39, 139, 1),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: backGroundGrad,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.all(8),
              height: 200,
              decoration: const BoxDecoration(
                gradient: bottomSheetGrad,
                borderRadius: BorderRadius.all(Radius.circular(15)),

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Enter Your Region:", style: font20b,),
                  AutoCompleteWidget(),
                  ElevatedButton(
                    onPressed: (){

                    },
                    child: Text("Get the Forecast", style: font20,),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(28, 27, 51, 0.26)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
