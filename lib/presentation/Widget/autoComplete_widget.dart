import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/model/bloc_state.dart';
import 'package:project/presentation/globals.dart';
import 'package:shimmer/shimmer.dart';
import '../../bloc/bloc.dart';
import '../../core/model/autoComplete.dart';
import '../../logic/BlocListener_logic.dart';
import 'TextFieldStyled_widget.dart';

int? regionId;
late TextEditingController textEditingController;

class AutoCompleteWidget extends StatefulWidget {
  const AutoCompleteWidget({Key? key}) : super(key: key);

  @override
  State<AutoCompleteWidget> createState() => _AutoCompleteWidgetState();
}

class _AutoCompleteWidgetState extends State<AutoCompleteWidget> {
  OverlayEntry? overlayEntry;
  final layerLink = LayerLink();
  final focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
      } else {
        hideOverlay();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }

  void showOverlay({List<AutoComplete>? list}) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    bool loading = true;
    if(list != null) loading = false;

    overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return Positioned(
          width: size.width - 16,
          height: loading
              ? 150
              : list!.length <= 3
                  ? list.length * 50
                  : 180,
          child: CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height - 7),
              child: loading
                  ? buildOverlay(null)
                  : buildOverlay(list)));
    });

    overlay.insert(overlayEntry!);
  }

  void hideOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Material(
          color: Colors.transparent,
          child: BlocConsumer<HomeBloc, HomeState>(builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: CompositedTransformTarget(
                  link: layerLink,
                  child: TextFieldStyled(
                    hintText: "Enter your region",
                    focusNode: focusNode,
                    controller: textEditingController,
                    onChanged: (s) {
                      if (s != null) {
                        context
                            .read<HomeBloc>()
                            .add(AutoCom(data: s.toLowerCase()));
                      }
                      setState(() {});
                    },
                  )),
            );
          }, listener: (BuildContext context, HomeState state) {
            if (focusNode.hasFocus) {
              print(state.autoComplete.status.toString());
              BlocListenerLogic(
                  state: state.autoComplete,
                  data: state.autoComplete.data,
                  initialFunction: () {
                    print('@ini');
                    hideOverlay();
                  },
                  successFunction: (data) {
                    print('suc');
                    hideOverlay();
                    showOverlay(list: data);
                  },
                  loadingFunction: (data) {
                    print('loading');
                    hideOverlay();
                    showOverlay(list: null);
                  },
                  errorFunction: (){}
              );
            } else {
              hideOverlay();
            }
          })),
    );
  }

  Widget buildOverlay(List<AutoComplete>? list) {
    bool loading = false;
    if(list == null) loading = true;
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(0),
          height: loading
              ? 180
              : list!.length <= 3
                  ? list.length * 50
                  : 150,
          decoration: BoxDecoration(
              gradient: backGroundGrad,
              border: Border.all(color: Colors.black12, width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                  blurRadius: 12,
                  spreadRadius: 0,
                  offset: Offset(0, -constraints.maxHeight),
                ),
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                  blurRadius: 12,
                  spreadRadius: 0,
                  offset: Offset(constraints.maxWidth, 0),
                ),
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.2),
                  blurRadius: 12,
                  spreadRadius: 0,
                  offset: Offset(0, constraints.maxHeight),
                ),
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.2),
                  blurRadius: 12,
                  spreadRadius: 0,
                  offset: Offset(-constraints.maxWidth, 0),
                ),
              ]),
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: loading ? 3 : list!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String element =
                        loading ? "j" : "${list![index].name}, ${list![index].region}, ${list![index].country}";
                    return GestureDetector(
                        child: Container(
                      height: 50,
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(0),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 0.5, color: Colors.white38))),
                      child: ListTile(
                        title: loading
                            ? SizedBox(
                                height: 18,
                                width: 200,
                                child: Shimmer.fromColors(
                                  baseColor: Colors.white12,
                                  highlightColor: Colors.white60,
                                  child: Container(
                                    height: 10,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.white60,
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                ))
                            : Text(
                                element,
                                style: font20,
                              ),
                        onTap: () {
                          textEditingController.text = loading ? "" : element;
                          hideOverlay();
                          regionId = list?[index].id;
                          focusNode.unfocus();
                        },
                      ),
                    ));
                  }),
            );
          }),
        ),
      ),
    );
  }
}
