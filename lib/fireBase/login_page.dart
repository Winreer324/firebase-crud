import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/authentication_with_phone.dart';
import 'package:flutter/material.dart';

// Google provider
import 'package:google_sign_in/google_sign_in.dart';

// Facebook provider
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';

// Twitter provider
//import 'package:flutter_twitter_login/flutter_twitter_login.dart';
//import 'package:leadning_firebase_raja/authentication_with_phone.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;

//  google sing in
  GoogleSignIn googleAuth = GoogleSignIn();

//  facebook sing
//  FacebookLogin fbLogin = FacebookLogin();

//  twitter sing
//  var twitterLogin = TwitterLogin(
//    consumerKey: "",
//    consumerSecret: ""
//  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 145),
                ),
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
                  },
                  obscureText: true,
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  child: Text('Login'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 7.0,
                  onPressed: () {
                    FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                      email: _email, password: _password)
                      .then((FirebaseUser user) {
                      Navigator.of(context).pushReplacementNamed('/homepage');
                    }).catchError((e) {
                      print(e);
                    });
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  child: Text('Login with Phone'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 7.0,
                  onPressed: () {
//                    Navigator.of(context).pushReplacementNamed('/phonepage');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AuthenticationWithPhone()));
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  child: Text('Login with Twitter'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 7.0,
                  onPressed: () {
//                  twitterLogin.authorize().then((result){
//                    switch(result.status){
//                      case TwitterLoginStatus.cancelledByUser:print("Canselled by you");break;
//                      case TwitterLoginStatus.error:print("Error");break;
//                      case TwitterLoginStatus.loggedIn:
//                        FirebaseAuth.instance.signInWithTwitter(
//                            authToken: result.session.token,
//                            authTokenSecret: result.session.secret
//                        ).then((signedInUser){
//                          Navigator
//                              .of(context)
//                              .pushReplacementNamed("/homepage");
//                        }).catchError((e){
//                          print(e);
//                        });
//                        break;
//                    }
//                  }).catchError((e){
//                    print(e);
//                  });
                  },
                ),
//                SizedBox(height: 20.0),
//                RaisedButton(
//                  child: Text('Login with Facebook'),
//                  color: Colors.blue,
//                  textColor: Colors.white,
//                  elevation: 7.0,
//                  onPressed: () {
//                    fbLogin.logInWithReadPermissions(["email","public_profile"])
//                      .then((result){
//                        switch(result.status){
//                          case FacebookLoginStatus.error:print('Error');break;
//                          case FacebookLoginStatus.cancelledByUser:print('Cancelled by you');break;
//                          case FacebookLoginStatus.loggedIn:
//                            FirebaseAuth.instance.signInWithFacebook(
//                                accessToken: result.accessToken.token)
//                            .then((signedInUser){
//                              print("Signed in as ${signedInUser.displayName}");
//                              Navigator.of(context).pushReplacementNamed("/homepage");
//                            }).catchError((e){
//                              print(e);
//                            });break;
//                        }
//                    }).catchError((e){
//                      print(e);
//                    });
//                  },
//                ),
                SizedBox(height: 20,),
                RaisedButton(
                  child: Text('Login with Google'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 7.0,
                  onPressed: () {
                    googleAuth.signIn().then((result){
                      result.authentication.then((googleKey){
                        FirebaseAuth.instance
                            .signInWithGoogle(
                            idToken: googleKey.idToken,
                            accessToken: googleKey.accessToken)
                            .then((signedInUser){
                              print("Sing in as ${signedInUser.displayName}");
                              Navigator.of(context).pushReplacementNamed("/homepage");
                            })
                            .catchError((e){
                          print(e);
                        });
                      }).catchError((e){
                        print(e);
                      });
                    }).catchError((e){
                      print(e);
                    });
                  },
                ),
                SizedBox(height: 15.0),
                Text('Don\'t have an account?'),
                SizedBox(height: 10.0),
                RaisedButton(
                  child: Text('Sign Up'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 7.0,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                ),
              ],
            )
          ),
        ),
      )
    );
  }
}
