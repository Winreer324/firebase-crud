import 'package:firebase_crud/authentication_with_phone.dart';
import 'package:firebase_crud/fireBase/home_page_aut.dart';
import 'package:firebase_crud/fireBase/login_page.dart';
import 'package:firebase_crud/fireBase/sign_up_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/landingpage': (BuildContext context)=> new MyApp(),
        '/signup': (BuildContext context) => new SignUpPage(),
        '/homepage': (BuildContext context) => new HomePage(),
        '/phonepage': (BuildContext context) => new AuthenticationWithPhone()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);

//  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        title: Text(widget.title),
        title: Text("lol"),
      ),
      body:  Center(
        child: Text("lol"),
      )
    );
  }
}
