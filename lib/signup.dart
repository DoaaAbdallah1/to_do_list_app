// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_app/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
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
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      CollectionReference users =
                          FirebaseFirestore.instance.collection('users');
                      DatabaseReference ref =
                          FirebaseDatabase.instance.ref("users");

                      await ref.child(credential.user!.uid).set({
                        'email': emailController.text,
                        'password': passwordController.text
                      });
                      FirebaseDatabase.instance
                          .ref('counter')
                          .child(FirebaseAuth.instance.currentUser!.uid)
                          .set({"index": 0});

                      users.doc(credential.user!.uid).set({
                        'email': emailController.text,
                        'password': passwordController.text
                      });

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                    // Navigate to the home screen
                  },
                  icon: Icon(Icons.login)),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
