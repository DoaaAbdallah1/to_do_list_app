import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  const Counter({super.key,required this.funtionCounter,required this.myList});
  final List myList;
  final int funtionCounter;
  @override
  Widget build(BuildContext context) {
    return Text(
      "${funtionCounter}/${myList.length}",
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}
