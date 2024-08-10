// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Cerd extends StatelessWidget {
  Cerd(
      {super.key,
      required this.myTask,
      required this.fun,
      required this.index,
      required this.doneOrNot,
      required this.myControllerTitle,
      required this.changeTitle,
      required this.removeIndex});
  final String myTask;
  bool doneOrNot;
  final String index;
  final Function removeIndex;
  final Function fun;

  final myControllerTitle;
  final Function changeTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //DatabaseReference ref = FirebaseDatabase.instance.ref("task");

      //  fun(index);
        
      },
      child: Container(
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.only(left: 15, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(style: BorderStyle.solid)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    

                    fun(index);
                  
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: doneOrNot
                          ? Color.fromARGB(254, 223, 189, 67)
                          : Colors.white,
                      border:
                          Border.all(color: Color.fromARGB(254, 223, 189, 67)),
                    ),
                    child: Icon(
                      doneOrNot ? Icons.check : Icons.close,
                      color: Colors.white,
                      size: 21,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  myTask,
                  style: TextStyle(
                      color: Color.fromARGB(252, 139, 139, 139),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        myControllerTitle.text = myTask;
                        showDialog(
                            context: context,
                            builder: (BuildContext) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11)),
                                child: Container(
                                  height: 220,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(20),
                                        child: TextField(
                                          controller: myControllerTitle,
                                          maxLength: 13,
                                        ),
                                      ),
                                      FilledButton(
                                          onPressed: () {
                                            //  fun2();
                                            changeTitle(index);

                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "change",
                                            style: TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      icon: Icon(
                        Icons.edit_note_rounded,
                        color: Color.fromARGB(254, 223, 189, 67),
                        size: 20,
                      )),
                  IconButton(
                      onPressed: () {
                        removeIndex(index);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Color.fromARGB(254, 223, 189, 67),
                        size: 20,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
