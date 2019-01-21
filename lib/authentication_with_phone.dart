import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationWithPhone extends StatefulWidget {
  @override
  _AuthenticationWithPhoneState createState() => _AuthenticationWithPhoneState();
}

class _AuthenticationWithPhoneState extends State<AuthenticationWithPhone> {

  String phoneNum;
  String smsCode;
  String verificationId;

  Future<void> verifyPhone() async{

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId){
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]){
      this.verificationId = verId;
      smsCodeDialog(context).then((value){
        print("Signed in");
      }).catchError((e){print(e);});
    };

    final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user){
      print("Verified");
    };

    final PhoneVerificationFailed verifiedFailed = (AuthException e){
      print("${e.message}");
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNum,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifiedFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve
    );
  }

  Future<bool> smsCodeDialog(BuildContext context){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Enter sms Code (554456)"),
          content: TextField(
            onChanged: (String value){
              this.smsCode = value;
            },
          ),
          contentPadding: EdgeInsets.all(15),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                FirebaseAuth.instance.currentUser().then((user){
                  if(user != null){
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed("/homepage");
                  }else {
                    Navigator.of(context).pop();
                    signIn();
                  }
                }).catchError((e){
                  print(e);
                });
              },
              child: Text("Done")
            )
          ],
        );
      }
    );
  }

  signIn(){
    FirebaseAuth.instance.signInWithPhoneNumber(
        verificationId: verificationId,
        smsCode: smsCode
    ).then((user){
      Navigator.of(context).pushReplacementNamed("/homepage");
    }).catchError((e){print(e);});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authentication with Phone"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                  decoration: InputDecoration(hintText: 'Enter phone number (+7 999 999-99-99)'),
                  onChanged: (value) {
                    setState(() {
                      this.phoneNum = value;
                    });
                  }),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text('Verity'),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: verifyPhone,
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text('Sign in as Guest'),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: (){
                  FirebaseAuth.instance.signInAnonymously().then((FirebaseUser user){
                    Navigator.of(context).pushReplacementNamed("/homepage");
                  }).catchError((e){
                    print(e);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
