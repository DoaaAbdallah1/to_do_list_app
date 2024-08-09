// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_app/class/docerd.dart';
import 'package:to_do_list_app/firebase_options.dart';
import 'package:to_do_list_app/login.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          } else if (snapshot.hasError) {
            return Text("");
          } else if (snapshot.hasData) {
            return ToDoList();
          } else {
            return Login();
          }
        },
      ),
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
  List myList = [];
  List foundToDo = [];
  DatabaseReference ref = FirebaseDatabase.instance.ref("tasks");

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
  removeIndex(int index) async {
    
      //foundToDo.remove(foundToDo[index]);
      await ref
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child("$index")
          .remove();
    
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

  User? user;
  DatabaseReference? taskRef;
  void initState() {
    foundToDo = myList;

    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      taskRef = FirebaseDatabase.instance.ref('tasks').child(user!.uid);
    }
    super.initState();
  }

  int i = 0;
  funAddTask() async {
    //foundToDo.add(Task(title: addTask, status: false));
    //  var uuid = Uuid();

    await ref
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("$i")
        .set({'title': addTask, 'status': false,'id':i});

    i++;
  }

  changeTitle(int index) async {
    //foundToDo[index].title = myControllerTitle.text;
    await ref
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("$index")
        .update({'title': myControllerTitle.text});
  }

  changeStatus(int index) async {
    //  foundToDo[index].status = !foundToDo[index].status;
    await ref
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("$index")
        .update({'status': false});
  }

  @override
  Widget build(BuildContext context) {
    //DatabaseReference ref = FirebaseDatabase.instance.ref("tasks");
    // Object? test = "";
    // ref.child(FirebaseAuth.instance.currentUser!.uid).onValue.listen((event) {
    //   var data = event.snapshot.value;
    //     test = data;
    // });

    //print(test);

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ));
                },
                icon: Icon(Icons.delete_outline))
          ],
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
            //  print(test);
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
            //  print(test);
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
                  SizedBox(
                      height: 530,
                      child: Expanded(
                          child: FirebaseAnimatedList(
                              query: ref.child(
                                  FirebaseAuth.instance.currentUser!.uid),
                              itemBuilder:
                                  (context, snapshot, index, animation) {
                                    Object? indexPoint=snapshot.child("id").value;
                                return Cerd(
                                  myTask:
                                      snapshot.child("title").value.toString(),
                                  doneOrNot: true,
                                  fun: changeStatus,
                                  fun2: fun,
                                  index:0,
                                  myControllerTitle: myControllerTitle,
                                  changeTitle: changeTitle,
                                  removeIndex: removeIndex,
                                );
                              }))

                      ///end
                      )
                ],
              ),
            ),
          ),
        ));
  }
}
