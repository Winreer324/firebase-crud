import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crud/services/crud.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uid = "";

  String carModel;
  String carColor;

  QuerySnapshot  carQS;

//  start

  CRUDMedthods crudObj = new CRUDMedthods();

  Future<bool> addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Data', style: TextStyle(fontSize: 15.0)),
            content: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: 'Enter car Name'),
                  onChanged: (value) {
                    this.carModel = value;
                  },
                ),
                SizedBox(height: 5.0),
                TextField(
                  decoration: InputDecoration(hintText: 'Enter car color'),
                  onChanged: (value) {
                    this.carColor = value;
                  },
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Add'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  crudObj.addData({
                    'carName': this.carModel,
                    'color': this.carColor
                  }).then((result) {
                    dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              )
            ],
          );
        });
  }

  Future<bool> updateDialog(BuildContext context, selectedDoc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Data', style: TextStyle(fontSize: 15.0)),
            content: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: 'Enter car Name'),
                  onChanged: (value) {
                    this.carModel = value;
                  },
                ),
                SizedBox(height: 5.0),
                TextField(
                  decoration: InputDecoration(hintText: 'Enter car color'),
                  onChanged: (value) {
                    this.carColor = value;
                  },
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Update'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  crudObj.updateData(selectedDoc,{
                    'carName': this.carModel,
                    'color': this.carColor
                  }).then((result) {
//                    dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              )
            ],
          );
        }
    );
  }

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Job Done', style: TextStyle(fontSize: 15.0)),
          content: Text('Added'),
          actions: <Widget>[
            FlatButton(
              child: Text('Alright'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

// end

  getUid(){

  }

  @override
  void initState() {

    crudObj.getData().then((result){
      setState(() {
        carQS = result;
      });
    });


    this.uid = "";
    FirebaseAuth.instance.currentUser().then((value){
      setState(() {
        this.uid = value.uid;
      });
    }).catchError((e){
      print(e);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            FirebaseAuth.instance.signOut().then((action) {
              Navigator.of(context).pushReplacementNamed("/landingpage");
            }).catchError((e) {
              print(e);
            });
          }
          ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              addDialog(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              crudObj.getData().then((result){
                setState(() {
                  carQS = result;
                });
              });
            },
          ),
        ],
      ),
      body:
//        Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            Text("You are now logged in as: "),
//            SizedBox(height: 5,),
//            Container(width: 320,child: Text(this.uid,overflow: TextOverflow.ellipsis,)),
//            Container(
//              child:
              _carList(),
//            )
//          ]
//      ),
    );
  }

  Widget _carList() {
//    if(carQS !=null){
      return StreamBuilder(
        stream: Firestore.instance.collection("testcrud").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            padding: EdgeInsets.all(15),
            itemBuilder: (context, index){
              return ListTile(
                title: Text(snapshot.data.documents[index].data["carName"]),
                subtitle: Text(snapshot.data.documents[index].data["color"]),
                onTap: (){
                  updateDialog(context, snapshot.data.documents[index].documentID);
                },
                onLongPress: (){
                  crudObj.deleteData(snapshot.data.documents[index].documentID);
                },
              );
            },
          );
        }
      );
//    } else return Center(child: Text("Loading...."));
  }
}
