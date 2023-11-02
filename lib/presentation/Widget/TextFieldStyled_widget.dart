import 'package:flutter/material.dart';
import '../globals.dart';

class TextFieldStyled extends StatelessWidget {
  final dynamic controller;
  final dynamic focusNode;
  final dynamic onEditingComplete;
  final dynamic onSubmitted;
  final dynamic onChanged;
  final String hintText;

  const TextFieldStyled(
      {super.key,
        this.controller,
        this.focusNode,
        this.onEditingComplete,
        this.onSubmitted,
        this.onChanged,
        required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        gradient: backGroundGrad,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: LayoutBuilder(
          builder: (context, constraints) {
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
                  offset: Offset(constraints.maxWidth , 0),
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
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                onEditingComplete: onEditingComplete,
                style: font20,
                onSubmitted: onSubmitted,
                onChanged: onChanged,
                decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: font15l,
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    fillColor: Colors.transparent,
                    border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
              ),
            );
          }
        ),
      ),
    );
  }
}