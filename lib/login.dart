import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_app/main.dart';
import 'package:to_do_list_app/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              IconButton(
                  onPressed: () async {
                     try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
        //  / Navigate to the home screen
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => ToDoList()));
                
    } on FirebaseAuthException catch (e) {
      print("ERROR :  ${e.code} ");
    }
                      },
                  icon: Icon(Icons.login)),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUp()),
                    );
                  },
                  child: Text("create account"))
            ],
          ),
        ),
      ),

        appBar: AppBar(
        title: Text('log in'),
      ),
    );
  }
}
