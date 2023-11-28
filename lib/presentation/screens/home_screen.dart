import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/logic/BlocBuilder_logic.dart';
import 'package:project/presentation/Widget/autoComplete_widget.dart';
import 'package:project/presentation/Widget/canvas.dart';
import 'package:project/presentation/Widget/getForecastBottom.dart';
import 'package:project/presentation/Widget/InternetAndLocationState_widget.dart';
import 'package:project/presentation/Widget/popupDialog.dart';
import 'package:project/sharedPreference/sharedPreference_get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/bloc.dart';
import '../Widget/bottomSheet_widget.dart';
import '../Widget/searchedRegion.dart';
import '../globals.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  double extantOfBottomSheet = 0.4;
  double positionOfBottomSheet = 100 / 42;
  bool positionOfBottomSheetBool = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      extantOfBottomSheet = state.getExtent;
      positionOfBottomSheet = (extantOfBottomSheet - 0.4) * 100 / 42;
      positionOfBottomSheetBool = positionOfBottomSheet > 0.6 ? true : false;

      List<Widget> animatedSwitcherData = [
        BlocBuilderLogic(
          state: state.myForecast,
          successWidget: AnimatedDefaultTextStyle(
            duration: const Duration(seconds: 2),
            style: positionOfBottomSheetBool ? font20l : fontBig,
            child: Text(
                "${(state.myForecast.data.currentModel.temp_c.toString())}°"),
          ),
        ),
        AnimatedOpacity(
          opacity: positionOfBottomSheetBool ? 1 : 0,
          duration: const Duration(seconds: 2),
          child: const Text(
            "|",
            style: font20l,
          ),
        ),
        BlocBuilderLogic(
          state: state.myForecast,
          successWidget: Text(state.myForecast.data.currentModel.condition.text,
              style: font20l),
        ),
      ];

      List<Widget> topDataOfHomeScreen = [
        BlocBuilderLogic(
          state: state.myForecast,
          successWidget: Text(
              state.myForecast.data.locationModel.name.toString(),
              style: font34),
        ),
        AnimatedSwitcher(
          duration: const Duration(seconds: 2),
          child: positionOfBottomSheetBool
              ? Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: animatedSwitcherData,
                    )
                  ],
                )
              : Column(
                  children: animatedSwitcherData,
                ),
        ),
        AnimatedOpacity(
          opacity: positionOfBottomSheetBool ? 0 : 1,
          duration: const Duration(seconds: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilderLogic(
                state: state.myForecast,
                successWidget: Text(
                    "H:${state.myForecast.data.forecastModel[0].day.maxtemp_c.toString()}°",
                    style: font20b),
              ),
              const SizedBox(
                width: 10,
              ),
              BlocBuilderLogic(
                  state: state.myForecast,
                  successWidget: Text(
                      "L:${state.myForecast.data.forecastModel[0].day.mintemp_c.toString()}°",
                      style: font20b)),
            ],
          ),
        ),
      ];

      return Scaffold(
          backgroundColor: const Color.fromRGBO(69, 39, 139, 1),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                    gradient: backGroundGrad,
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: positionOfBottomSheet * size.height,
                  child: Container(
                      height: size.height,
                      width: size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              const AssetImage("assets/images/background.jpg"),
                          opacity: 1 - positionOfBottomSheet,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: null),
                ),
                AnimatedPositioned(
                  duration: const Duration(seconds: 2),
                  top: positionOfBottomSheetBool
                      ? (size.width * 20 / 100) - 10
                      : (size.width * 20 / 100) - 40,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: topDataOfHomeScreen),
                ),
                Positioned(
                  bottom: 50 + positionOfBottomSheet * size.height,
                  left: 0,
                  child: Container(
                      width: (size.width),
                      height: (size.height - 312),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage("assets/images/house.png"),
                          fit: BoxFit.fitWidth,
                          opacity: 1 - positionOfBottomSheet,
                        ),
                      ),
                      child: null),
                ),
                const BottomSheetWidget(),
                Positioned(
                  bottom: (-positionOfBottomSheet) * size.height,
                  left: 0,
                  child: SizedBox(
                    width: size.width,
                    height: 80,
                    child: CustomPaint(
                      painter: TabBarPaint(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: (-positionOfBottomSheet * 3) * size.height,
                  left: 0,
                  child: SizedBox(
                    width: size.width,
                    height: 80,
                    child: CustomPaint(
                      painter: SubtractPaint(),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Positioned(
                        bottom: 8 + (-positionOfBottomSheet * 3) * size.height,
                        left: size.width / 2 - 31,
                        child: const AddRegionIconButton()),
                    Positioned(
                        bottom: 11 + (-positionOfBottomSheet * 3) * size.height,
                        left: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.settings),
                                color: Colors.white60,
                                iconSize: 30,
                              ),
                              IconButton(
                                onPressed: () {
                                  GetPrefs.get()
                                      .then((List<SearchedRegion> data) {
                                    context
                                        .read<HomeBloc>()
                                        .add(GetSearchedRegion(data: data));
                                  });
                                  Navigator.pushNamed(
                                      context, '/searchedRegion_screen');
                                },
                                icon: const Icon(Icons.list),
                                color: Colors.white60,
                                iconSize: 30,
                              ),
                            ],
                          ),
                        )),
                  ],
                )
              ],
            ),
          ));
    });
  }
}

class AddRegionIconButton extends StatefulWidget {
  const AddRegionIconButton({Key? key}) : super(key: key);

  @override
  State<AddRegionIconButton> createState() => _AddRegionIconButtonState();
}

class _AddRegionIconButtonState extends State<AddRegionIconButton> {
  late Gradient gradient = button1G;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(0, 0, 0, 0.4),
            Color.fromRGBO(255, 255, 255, 0.4)
          ], stops: [
            0.2,
            1
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              blurRadius: 10,
              offset: Offset(4, 4),
            ),
            BoxShadow(
              color: Color.fromRGBO(255, 255, 255, 0.2),
              blurRadius: 10,
              offset: Offset(-4, -4),
            )
          ]),
      child: Center(
        child: Container(
          height: 58,
          width: 58,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            gradient: gradient,
          ),
          child: IconButton(
            iconSize: 44,
            onPressed: () async {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) => PopupDialog(
                  action: (){},
                  mainWidget: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 14.0),
                            child: Text(
                              "Enter your Region:",
                              style: font20b,
                            ),
                          ),
                        ],
                      ),
                      const AutoCompleteWidget(),
                      GetForecastBottom(pop: true),
                    ],
                  ),
                ),
              );
              setState(() {
                gradient = button2G;
              });
              await Future.delayed(
                const Duration(seconds: 1),
              );
              setState(() {
                gradient = button1G;
              });
            },
            icon: const Icon(Icons.add_rounded),
            color: const Color.fromRGBO(72, 49, 159, 1),
          ),
        ),
      ),
    );
  }
}
