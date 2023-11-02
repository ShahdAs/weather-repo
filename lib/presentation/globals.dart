import 'package:flutter/material.dart';

const Gradient button2G = LinearGradient(
    colors: [
      Color.fromRGBO(255, 255, 255, 0),
      Color.fromRGBO(187, 191, 199, 1)
    ],
    stops: [
      0,
      1
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

const Gradient button1G = LinearGradient(
    colors: [
      Color.fromRGBO(255, 255, 255, 0.9),
      Color.fromRGBO(187, 191, 199, 1)
    ],
    stops: [
      0,
      1
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

const Gradient bottomSheetGrad = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Color.fromRGBO(46, 51, 90, 0.26),
      Color.fromRGBO(28, 27, 51, 0.26)
    ]);
const Gradient backGroundGrad = LinearGradient(colors: [
  Color.fromRGBO(46, 51, 90, 1),
  Color.fromRGBO(69, 39, 139, 1),
], stops: [
  0.1,
  0.9,
], begin: Alignment.topLeft, end: Alignment.centerRight);
const Gradient navGrad1 = LinearGradient(colors: [
  Color.fromRGBO(58, 58, 106, 1),
  Color.fromRGBO(37, 36, 76, 1),
], stops: [
  0.1,
  1,
], begin: Alignment.centerLeft, end: Alignment.centerRight);
const Gradient navGrad2 = LinearGradient(colors: [
  Color.fromRGBO(62, 63, 106, 1),
  Color.fromRGBO(46, 51, 90, 1),
], stops: [
  0.1,
  1,
], begin: Alignment.topCenter, end: Alignment.bottomCenter);
const Gradient boldGrad = LinearGradient(colors: [
  Color.fromRGBO(72, 49, 157, 0.2),
  Color.fromRGBO(72, 49, 157, 0)
], stops: [
  0.1,
  1,
], begin: Alignment.topCenter, end: Alignment.bottomCenter);

const Gradient lightGrad = LinearGradient(colors: [
  Color.fromRGBO(72, 49, 157, 0.7),
  Color.fromRGBO(72, 49, 157, 0)
], stops: [
  0.1,
  1,
], begin: Alignment.topCenter, end: Alignment.bottomCenter);

const Gradient selectGrad = LinearGradient(colors: [
  Color.fromRGBO(75, 49, 157, 1),
  Color.fromRGBO(72, 49, 157, 0)
], stops: [
  0,
  0.7,
], begin: Alignment.topCenter, end: Alignment.bottomCenter);

const TextStyle font15 = TextStyle(
  color: Colors.white,
  fontSize: 15,
  fontFamily: "SF",
  fontWeight: FontWeight.bold,
);
const TextStyle font15l = TextStyle(
  color: Colors.white54,
  fontSize: 15,
  fontFamily: "SF",
  fontWeight: FontWeight.bold,
);
const TextStyle font20 = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontFamily: "SF",
  fontWeight: FontWeight.bold,
);

const TextStyle fontB = TextStyle(
  color: Color.fromRGBO(34, 203, 216, 1),
  fontSize: 13,
  fontFamily: "SF",
  fontWeight: FontWeight.bold,
);

const TextStyle font20l = TextStyle(
  color: Colors.white54,
  fontSize: 20,
  fontFamily: "SF",
  fontWeight: FontWeight.w600,
  height: 0.5,
);

const TextStyle font20red = TextStyle(
  color: Color.fromRGBO(28, 27, 51, 01),
  fontSize: 17,
  fontFamily: "SF",
  fontWeight: FontWeight.w600,
  height: 0.5,
);

const TextStyle font20b = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: "SF",
    fontWeight: FontWeight.w600);

const TextStyle fontBig = TextStyle(
  color: Colors.white,
  fontSize: 109,
  height: 1,
  fontFamily: "SF",
);

const TextStyle font34 = TextStyle(
  color: Colors.white,
  fontSize: 34,
  fontFamily: "SF",
  height: 1,
);
const TextStyle font34b = TextStyle(
    color: Colors.white,
    fontSize: 34,
    fontFamily: "SF",
    height: 1,
    fontWeight: FontWeight.w600);
const TextStyle font30 = TextStyle(
  color: Colors.white,
  fontSize: 30,
  fontFamily: "SF",
  height: 1,
);

// class Global with ChangeNotifier{
//   static Global? _instance;
//
//   Global._internal(){
//     var _myForecastVar;
//     var _myCurrentVar;
//   }
//
//   static Global getInstance(){
//     _instance ??= Global._internal();
//     return _instance!;
//   }
//   late List<Forecast> _myForecastVar;
//   late List<Current>  _myCurrentVar;
//
//   List<Forecast> get myForecastVar => _myForecastVar;
//   List<Current> get myCurrentVar => _myCurrentVar;
//
//   void set myForecastVar(List<Forecast>  newForecast) {
//     _myForecastVar = newForecast;
//     notifyListeners();
//   }
//   void set myCurrentVar(List<Current> newCurrent){
//     _myCurrentVar = newCurrent;
//     notifyListeners();
//   }
//
//   bool isnull() {
//     if (myCurrentVar == null) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//
//
//
//
// }
