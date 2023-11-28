import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/bloc/bloc.dart';
import 'package:project/cubit/internet_connection_cubit.dart';
import 'package:project/logic/BlocBuilder_logic.dart';
import 'package:project/presentation/Widget/Region_widget.dart';
import 'package:project/presentation/Widget/TextFieldStyled_widget.dart';
import 'package:project/presentation/globals.dart';
import '../../logic/InternetConnectionCubitListener_logic.dart';
import '../../sharedPreference/sharedPreference_get.dart';
import '../Widget/searchedRegion.dart';

class SearchedRegionPage extends StatefulWidget {
  const SearchedRegionPage({super.key});

  static String _displayStringForOption(SearchedRegion option) =>
      option.name.toLowerCase();

  @override
  State<SearchedRegionPage> createState() => SearchedRegionPageState();
}

class SearchedRegionPageState extends State<SearchedRegionPage> {
  late FocusNode focusNode;
  late TextEditingController textEditingController;
  List<SearchedRegion>? searchedRegionOptions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = FocusNode();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    focusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GetPrefs.get().then((List<SearchedRegion> data) {
      searchedRegionOptions = data;
      context.read<HomeBloc>().add(GetSearchedRegion(data: data));
    });
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: backGroundGrad),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: const Text(
              'My Regions',
              style: font30,
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: TextFieldStyled(
                  hintText: "Enter the region",
                  onEditingComplete: () {
                    sendEventOfSearchedRegionsList(textEditingController.text);
                  },
                  controller: textEditingController,
                  focusNode: focusNode,
                  onChanged: (changedText) {
                    sendEventOfSearchedRegionsList(changedText);
                  },
                  onSubmitted: (submittedText) {
                    sendEventOfSearchedRegionsList(submittedText);
                    focusNode.unfocus();
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(child:
                  BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
                builder: (context, internetState) {
                  return BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return BlocBuilderLogic(
                        state: state.getSearchedRegion,
                        successWidget: ListView.builder(
                          key: ValueKey<int>(state.getSearchedRegion.data!.length ?? 0),
                          padding: const EdgeInsets.all(0),
                          itemCount: state.getSearchedRegion.data!.length ?? 0,
                          itemBuilder: (context, index) {
                            SearchedRegion element =
                                state.getSearchedRegion.data.elementAt(index);
                            return ListTile(
                              horizontalTitleGap: 0,
                              title: RegionWidget(
                                region: element,
                              ),
                              onTap: () {
                                InternetConnectionCubitListenerLogic(
                                    state: internetState,
                                    data: element.name.toLowerCase(),
                                    internetConnectedFunction: (data) {
                                      context
                                          .read<HomeBloc>()
                                          .add(GetForecast(data: data));
                                    });
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        ),
                        errorWidget: const Text(
                          'No elements has been founded',
                          style: font20l,
                        ),
                      );
                    },
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  void sendEventOfSearchedRegionsList(var textBoxChangedText) {
    List<SearchedRegion>? searchedRegionsList;
    if (textBoxChangedText.toString() == '') {
      searchedRegionsList = searchedRegionOptions;
    } else {
      searchedRegionsList =
          searchedRegionOptions?.where((SearchedRegion option) {
        return SearchedRegionPage._displayStringForOption(option)
            .toString()
            .contains(textBoxChangedText.toString().toLowerCase());
      }).toList();
      print(searchedRegionsList?.map((e) => e.name).toList());
    }
    context.read<HomeBloc>().add(GetSearchedRegion(data: searchedRegionsList));
  }
}
