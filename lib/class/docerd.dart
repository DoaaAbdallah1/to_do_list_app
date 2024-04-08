// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Cerd extends StatelessWidget {
  const Cerd({super.key, required this.myTask,required this.doneOrNot});
  final String myTask;
  final bool doneOrNot;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 2.6, style: BorderStyle.solid)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            myTask,
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 22,
                fontWeight: FontWeight.w600),
          ),
          Icon(
            doneOrNot?Icons.check:  Icons.close,
            color:doneOrNot?Colors.green:Colors.red,
            size: 31,
          )
        ],
      ),
    );
  }
}
