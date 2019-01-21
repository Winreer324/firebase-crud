//import 'package:leadning_firebase_raja/services/user_management.dart';
import 'package:firebase_crud/services/user_management.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';


class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                }),
              SizedBox(height: 15.0),
              TextField(
                decoration: InputDecoration(hintText: 'Password'),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                }),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text('Sign Up'),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: () {
                  FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                    email: _email, password: _password)
                    .then((signedInUser) {
                    UserManagement().storeNewUser(signedInUser, context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              ),
            ],
          )
        ),
      )
    );
  }
}
