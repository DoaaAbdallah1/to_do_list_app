// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_list_app/class/counter.dart';
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

class Task {
  String title;
  bool status;
  Task({
    required this.title,
    required this.status,
  });
}

class _ToDoListState extends State<ToDoList> {
  List myList = [
    Task(title: "Publish video", status: true),
    Task(title: "Laugh louder", status: true),
    Task(title: "GEM", status: true),
    Task(title: "call mom", status: true),
  ];
  List foundToDo = [];
  final searchboxController = TextEditingController();
  final myController = TextEditingController();
  final myControllerTitle = TextEditingController();
  String addTask = "";
  String changeTask = "";
  fun() {
    setState(() {
      addTask = myController.text;
      changeTask = myControllerTitle.text;
    });
  }

  int functionCounter() {
    int c = 0;
    for (var i in myList) {
      if (i.status) {
        c++;
      }
    }
    return c;
  }

// remove task
  removeIndex(int index) {
    setState(() {
      foundToDo.remove(foundToDo[index]);
    });
  }

  void runFilter(String keyword) {
    List results = [];
    if (keyword.isEmpty) {
      results = myList;
    } else {
      results = myList
          .where((element) =>
              element.title.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundToDo = results;
    });
  }

  void initState() {
    foundToDo = myList;
    super.initState();
  }

  funAddTask() {
    foundToDo.add(Task(title: addTask, status: false));
  }

  changeTitle(int index) {
    setState(() {
      foundToDo[index].title = myControllerTitle.text;
    });
  }

  changeStatus(int index) {
    setState(() {
      foundToDo[index].status = !foundToDo[index].status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(254, 223, 189, 67),
          title: Text(
            "To-Do List",
            style: TextStyle(
                color: Color.fromARGB(255, 252, 252, 252),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            myController.text = "";
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: TextField(
                              controller: myController,
                              maxLength: 13,
                            ),
                          ),
                          FilledButton(
                              onPressed: () {
                                fun();
                                funAddTask();
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Add",
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ),
                  );
                });
          },
          backgroundColor: Color.fromARGB(254, 223, 189, 67),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Icon(
            Icons.add,
            color: Colors.white,
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
                children: [
                  //search bar
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    // padding:  EdgeInsets.symmetric(
                    //   horizontal: 20,
                    // ),
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      onChanged: (value) => runFilter(value),
                      controller: searchboxController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color.fromARGB(254, 223, 189, 67),
                          size: 20,
                        ),
                        prefixIconConstraints: BoxConstraints(
                          maxHeight: 14,
                          minWidth: 14,
                        ),
                        border: InputBorder.none,
                        hintText: 'Search',
                        // hintStyle: TextStyle()
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Today’s tasks",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  //counter
                  // Counter(
                  //   myList: myList,
                  //   funtionCounter: functionCounter(),
                  // ),
                  // items
                  Container(
                    height: 530,
                    child: ListView.builder(
                        itemCount: foundToDo.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Cerd(
                                myTask: foundToDo[index].title,
                                doneOrNot: foundToDo[index].status,
                                fun: changeStatus,
                                fun2: fun,
                                index: index,
                                myControllerTitle: myControllerTitle,
                                changeTitle: changeTitle,
                                removeIndex: removeIndex,
                              )
                            ],
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
