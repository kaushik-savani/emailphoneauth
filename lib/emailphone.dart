import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class emailauth extends StatefulWidget {
  const emailauth({Key? key}) : super(key: key);

  @override
  State<emailauth> createState() => _emailauthState();
}

class _emailauthState extends State<emailauth> {
  TextEditingController temail = TextEditingController();
  TextEditingController tpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("email authentication")),
      body: Column(
        children: [
          TextField(
            controller: temail,
          ),
          TextField(
            controller: tpassword,
          ),
          ElevatedButton(onPressed: () async {
            try {
              UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: temail.text,
                password: tpassword.text,
              );
              print(credential);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
              }
            } catch (e) {
              print(e);
            }
          }, child: Text("register")),
          ElevatedButton(onPressed: () async {
            try {
              UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: temail.text,
                  password: tpassword.text
              );
              print(credential);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                print('No user found for that email.');
              } else if (e.code == 'wrong-password') {
                print('Wrong password provided for that user.');
              }
            }
          }, child: Text("Login"))
        ],
      ),
    );
  }
}
