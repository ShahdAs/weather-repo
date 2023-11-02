import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/bloc/bloc.dart';
import 'package:project/presentation/Widget/Region_widget.dart';
import 'package:project/presentation/Widget/TextFieldStyled_widget.dart';
import 'package:project/presentation/globals.dart';

import '../Widget/searchedRegion.dart';

final List<SearchedRegion> searchedRegionOptions = <SearchedRegion>[
  SearchedRegion(
      name: 'hamah', region: 'hamah', country: 'syria', lon: 1.1, lat: 1.4),
  SearchedRegion(
      name: 'aleppo', region: 'hamah', country: 'lebanon', lon: 1.1, lat: 1.4),
  SearchedRegion(
      name: 'homs', region: 'hamah', country: 'syria', lon: 1.1, lat: 1.4),
  SearchedRegion(
      name: 'homf', region: 'hamah', country: 'palestine', lon: 1.1, lat: 1.4),
  SearchedRegion(
      name: 'homy', region: 'hamah', country: 'syria', lon: 1.1, lat: 1.4),
  SearchedRegion(
      name: 'homb', region: 'hamah', country: 'syria', lon: 1.1, lat: 1.4),
  SearchedRegion(
      name: 'hogs', region: 'hamah', country: 'syria', lon: 1.1, lat: 1.4),
  SearchedRegion(
      name: 'hord', region: 'hamah', country: 'syria', lon: 1.1, lat: 1.4),
  SearchedRegion(
      name: 'hoku', region: 'hamah', country: 'syria', lon: 1.1, lat: 1.4),
  SearchedRegion(
      name: 'hogh', region: 'hamah', country: 'syria', lon: 1.1, lat: 1.4),
];

class SearchedRegionScreen extends StatelessWidget {
  const SearchedRegionScreen({Key? key}) : super(key: key);

  const SearchedRegionScreen._();

  static Page<void> page() =>
      const MaterialPage<void>(child: SearchedRegionScreen._());

  @override
  Widget build(BuildContext context) {
    context
        .read<HomeBloc>()
        .add(GetSearchedRegion(data: searchedRegionOptions));
    return _SearchedRegionScreen();
  }
}

class _SearchedRegionScreen extends StatefulWidget {
  static String _displayStringForOption(SearchedRegion option) => option.name;

  @override
  State<_SearchedRegionScreen> createState() => _SearchedRegionScreenState();
}

class _SearchedRegionScreenState extends State<_SearchedRegionScreen> {
  late FocusNode focusNode;
  late TextEditingController textEditingController;

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
                    check(textEditingController.text);
                  },
                  controller: textEditingController,
                  focusNode: focusNode,
                  onChanged: (theText) {
                    check(theText);
                  },
                  onSubmitted: (theText) {
                    check(theText);
                    focusNode.unfocus();
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.getSearchedRegion.isSuccess()) {
                      return ListView.builder(
                          // clipBehavior: Clip.none,
                          // shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                          itemCount: state.getSearchedRegion.data.length,
                          itemBuilder: (context, index) {
                            SearchedRegion element =
                                state.getSearchedRegion.data.elementAt(index);
                            return ListTile(
                              horizontalTitleGap: 0,
                              // visualDensity: VisualDensity(horizontal: 2,vertical: 2),
                              title: RegionWidget(
                                region: element,
                              ),
                            );
                          });
                    } else {
                      return const CircularProgressIndicator(
                        color: Colors.white54,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void check(var theText) {
    if (theText.toString() == '') {
      List<SearchedRegion> searchedRegionsList = searchedRegionOptions;
      context
          .read<HomeBloc>()
          .add(GetSearchedRegion(data: searchedRegionsList));
    } else {
      List<SearchedRegion> searchedRegionsList =
          searchedRegionOptions.where((SearchedRegion option) {
        return _SearchedRegionScreen._displayStringForOption(option)
            .toString()
            .contains(theText.toString().toLowerCase());
      }).toList();
      context
          .read<HomeBloc>()
          .add(GetSearchedRegion(data: searchedRegionsList));
    }
  }
}
