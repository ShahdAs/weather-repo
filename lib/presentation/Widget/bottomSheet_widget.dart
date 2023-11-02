import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project/bloc/bloc.dart';
import 'package:project/presentation/Widget/currentDetailWidget.dart';
import '../globals.dart';
import 'tabBar_edited.dart';



var myForecastVar = myForecastVarbloc;




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
        if (state.getExtent.isSuccess()) {
          double extant = state.getExtent.data;
          double percent = (extant - 0.4) * 100 / 42;

          return NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                context
                    .read<HomeBloc>()
                    .add(GetExtant(data: notification.extent));
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
                            width: (MediaQuery.of(context).size.width),
                            height: MediaQuery.of(context).size.height - 156,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(80 - percent * 80)),
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
                            child: BlurryContainer(
                              blur: 30,
                              height: MediaQuery.of(context).size.height - 156,
                              borderRadius: BorderRadius.circular(
                                50 - percent * 50,
                              ),
                              width: (MediaQuery.of(context).size.width),
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
                                        decoration: const  BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(25)),
                                            color:  Color.fromRGBO(0, 0, 0, 0.3),
                                        ),
                                        margin: const EdgeInsets.all(9),
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
                                    width: (MediaQuery.of(context).size.width),
                                    child: const TabBarWidget(),
                                  ),
                                  const CurrentDetailWidget()
                                ],
                              ),
                            ),
                          )),
                    );
                  }));
        } else {
          return Container(
            child: null,
          );
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

class _TabBarWidgetState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
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
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.myForecast.isSuccess()) {
          myForecastVar = state.myForecast.data;
        }
      },
      child: Scaffold(
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
              width: (MediaQuery.of(context).size.width),
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
              children: [
                listWidget(myForecastVar.forecastModel, true),
                listWidget(myForecastVar.forecastModel, false)
              ],
            )),
          ],
        ),
      ),
    );
  }
}


Widget listWidget(var data, bool isHour) {
  return Builder(builder: (context) {
    int day = 2, hour = 0 ;
    for (int i = 0; i < 24; i++) {
      if (i == int.parse(DateFormat('H').format(DateTime.now()))) {
        hour = i;
      }
    }
    for(int i = 0; i<3; i++){
      if(DateFormat('d').format(DateTime.now()) == DateFormat('d').format(DateTime.parse(data[i].date))){
        day = i;
      }
    }
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        context.read<HomeBloc>().add(TheTimeIndex(data: [hour, day]));
        if (state.theTimeIndex.isSuccess()) {
          double hourNow = double.parse(state.theTimeIndex.data[0].toString());
          int dayNow = state.theTimeIndex.data[1];

          ScrollController scrollController = ScrollController(
              initialScrollOffset: 6 + 72 * hourNow,
              keepScrollOffset: true);

          return Container(
            margin: const EdgeInsets.all(6),
            height: 142,
            width: 100,
            child: ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: isHour ? data[dayNow].hour.length : data.length,
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
                        child: Container(
                          decoration: BoxDecoration(
                            color: (index == hourNow && isHour)
                                ? const Color.fromRGBO(72, 49, 157, 1)
                                : (isHour == false && index == dayNow)
                                    ? const Color.fromRGBO(72, 49, 157, 1)
                                    : null,
                            gradient: (hourNow == index && isHour)
                                ? selectGrad
                                : (isHour == false && index == dayNow)
                                    ? selectGrad
                                    : null,
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8.5, 16, 8.5, 0),
                                child: Text(
                                  isHour
                                      ? DateFormat('j').format(DateTime.parse(
                                          data[dayNow].hour[index].time))
                                      : DateFormat('E').format(
                                          DateTime.parse(data[index].date)),
                                  style: font15,
                                  maxLines: 1,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8.5, 8, 8.5, 0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 32,
                                      width: 32,
                                      child: Image.network(isHour
                                          ? "https:${data[dayNow].hour[index].condition.icon}"
                                          : "https:${data[index].day.condition.icon}"),
                                    ),
                                    Text(
                                      isHour
                                          ? "${data[dayNow].hour[index].chance_of_rain}%"
                                          : "${data[index].day.daily_chance_of_rain}%",
                                      style: fontB,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8.5, 16, 8.5, 0),
                                child: Text(
                                  isHour
                                      ? "${data[dayNow].hour[index].temp_c}°"
                                      : "${data[index].day.avgtemp_c}°",
                                  style: font15,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        } else {
          return Container(
            child: null,
          );
        }
      },
    );
  });
}
