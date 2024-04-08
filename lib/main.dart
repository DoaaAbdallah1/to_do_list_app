// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_list_app/class/docerd.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List myList = [
    Cerd(myTask: "call mom", doneOrNot: true),
    Cerd(myTask: "homework", doneOrNot: false),
    Cerd(myTask: "new project", doneOrNot: true),
    Cerd(myTask: "call dod", doneOrNot: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(99, 10, 100, 0.5),
          title: Text(
            "To-Do List",
            style: TextStyle(
                color: Color.fromARGB(255, 252, 252, 252),
                fontSize: 33,
                fontWeight: FontWeight.bold),
          ),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext) {
                  return Container(
                    height: double.infinity,
                    child: Column(
                      
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: TextField(
                            
                            maxLength: 13,
                          ),
                        ),
                        FilledButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Add",
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  );
                });
          },
          backgroundColor: Color.fromARGB(211, 218, 171, 223),
          child: Icon(
            Icons.add,
            color: Color.fromRGBO(99, 10, 100, 0.9),
            size: 33,
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 15, bottom: 15),
          width: double.infinity,
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [...myList.map((item) => item)],
              ),
            ),
          ),
        ));
  }
}
