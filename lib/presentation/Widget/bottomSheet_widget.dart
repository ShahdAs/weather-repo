import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/bloc/bloc.dart';
import '../../core/model/forecast.dart';
import '../globals.dart';
import 'tabBar_edited.dart';





class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({Key? key}) : super(key: key);

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
  builder: (context, state) {

    if(state.getExtent.isSuccess()){
      double extant = state.getExtent.data;
      double percent = (extant - 0.4) * 100 / 42;

      return  NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            context.read<HomeBloc>().add(GetExtant(data: notification.extent));
            return true;
          },
          child: DraggableScrollableSheet(
              snap: true,
              initialChildSize: 0.4,
              minChildSize: 0.4,
              maxChildSize: 0.8,
              builder: (BuildContext context, myScrollController) {
                return ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(0)),
                  child: SingleChildScrollView(
                      controller: myScrollController,
                      child: Container(
                        width: (MediaQuery
                            .of(context)
                            .size
                            .width),
                        height: MediaQuery
                            .of(context)
                            .size
                            .height -156,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(50 - percent * 50)),
                            gradient: bottomSheetGrad,
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(
                                      0, 0, 0, 0.2 - percent * 0.2),
                                  blurRadius: 15,
                                  offset: const Offset(0, -11),
                                  spreadRadius: 3,
                                  blurStyle: BlurStyle.inner),
                            ]),
                        child: Column(
                          children: [
                            BlurryContainer(
                              blur: 30,
                              height: MediaQuery
                                  .of(context)
                                  .size.height / 2,
                              borderRadius: BorderRadius.circular(
                                50 - percent * 50,
                              ),
                              width: (MediaQuery
                                  .of(context)
                                  .size
                                  .width),
                              padding: const EdgeInsets.all(0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Container(
                                        width: 48,
                                        height: 5,
                                        margin: const EdgeInsets.all(9),
                                        color: const Color.fromRGBO(
                                            0, 0, 0, 0.3),
                                      ),
                                      Container(
                                        height: 2,
                                        width: 286,
                                        decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  Color.fromRGBO(
                                                      255, 255, 255, 0),
                                                  Color.fromRGBO(
                                                      255, 255, 255, 0.1),
                                                  Color.fromRGBO(
                                                      255, 255, 255, 0)
                                                ]),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  blurRadius: 15,
                                                  offset: Offset(0, -11),
                                                  spreadRadius: 3),
                                            ]),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 200,
                                    width:
                                    (MediaQuery
                                        .of(context)
                                        .size
                                        .width),
                                    child: TabBarWidget(),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                );
              })
      );
    }
    else{
      return Container(child: null,);
    }
  },
);
  }
}

class TabBarWidget extends StatefulWidget {

  const TabBarWidget({Key? key}) : super(key: key);

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Global global = Global.getInstance();
    bool isnull = global.isnull();
    List<Forecast> myForecastVar = global.myForecastVar;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SizedBox(
            height: 25,
            child: TabBar(
              indicator: ShapeDecoration(
                shape: UnderlineInputBorderE(
                  borderSide: const BorderSide(),
                ),
              ),
              controller: _tabController,
              labelStyle: font15,
              tabs: const [
                Tab(
                  text: ("Hourly Forecast"),
                ),
                Tab(
                  text: ("Weekly Forecast"),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
            width: (MediaQuery
                .of(context)
                .size
                .width),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.2),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ]),
          ),
          Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [listWidget(myForecastVar, isnull), listWidget(myForecastVar, isnull)],
                    )
          ),
        ],
      ),
    );
  }
}

Widget listWidget(List<Forecast> data, bool isnull) {
  return Container(
    margin: const EdgeInsets.all(6),
    height: 142,
    width: 100,
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: data[0].hour.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: <Widget>[
            Container(
              height: 142,
              width: 60,
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  gradient: boldGrad,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                      color: const Color.fromRGBO(255, 255, 255, 0.05),
                      width: 1.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                      blurStyle: BlurStyle.outer,
                    ),
                  ]),
              child: BlurryContainer(
                borderRadius: BorderRadius.circular(30),
                blur: 10,
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.5, 16, 8.5, 0),
                      child: isnull ? const CircularProgressIndicator():Text(
                        "${data[0].hour[index].time.substring(11,13).trim()}",
                        style: font15,
                        maxLines: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.5, 8, 8.5, 0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 32,
                            width: 32,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/cloud.png"),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          isnull ?  const CircularProgressIndicator(): Text(
                            "${data[0].hour[index].chance_of_rain}%",
                            style: fontB,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.5, 16, 8.5, 0),
                      child: isnull ? const CircularProgressIndicator(): Text(
                        "${data[0].hour[index].temp_c}°",
                        style: font15,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}





