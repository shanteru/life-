

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'MapPage.dart';
import 'ProgressPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {



    const double kDefaultPadding = 20.0;
    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9E9E9),
        leading: IconButton(icon: Icon(Icons.menu),color: Colors.blueGrey, onPressed:(){

        }),
        title: Text("Welcome Back, Roger!", style: TextStyle(color: Color.fromRGBO(35, 77, 135,1.0), fontStyle: FontStyle.italic),),
        actions:<Widget>[
          IconButton(icon: Icon(Icons.search, color: Colors.blueGrey,), onPressed:(){

          }),
        ]
      ),
      body:
      Stack(
        children: [
          Align(
              alignment: Alignment(0,-0.7),
              child:Container(child: CircleAvatar(
                backgroundColor: Color.fromRGBO(232, 176, 176, 1.0),
                radius: 135.0,

              ))),
          Align(
              alignment: Alignment(0,-0.6),
              child:Container(child: CircleAvatar(
                backgroundColor: Color.fromRGBO(204, 94, 94, 1.0),
                radius: 120.0,

              ))),
          Align(
            alignment: Alignment(0,-0.5),
              child:
              RaisedButton(
                  child: Text('S O S',style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
                  color: Color.fromRGBO(209, 61, 61, 1.0),
                  splashColor: Colors.lightBlue,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(90.0),
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder:(context)=>ProgressPage()),
                    );

                  }
              )

),
          Align(
            alignment: Alignment(0,0.3),
            child:
                Text("Emergency Button", style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black38, fontSize: 18)),

          ),
          Align(
              alignment: Alignment(0,0.4),
              child:
              Text(" Press the button in case of emergency", style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black26))

          ),
          Align(
              alignment: Alignment(0,0.45),
              child:
              Text(" or just shake your phone", style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black26))

          ),




        ],
      ),

      // floatingActionButton : ListView(children: <Widget>[
      //   Container(
      //     //height: 150,
      //     margin: EdgeInsets.symmetric(vertical: 130.0),
      //     padding:EdgeInsets.symmetric(horizontal:30),
      //     child:RaisedButton(
      //       child: Text('Emergency',style: TextStyle(color: Colors.white)),
      //       color: Colors.red,
      //       splashColor: Colors.lightBlue,
      //       shape: CircleBorder(),
      //       padding: EdgeInsets.all(100.0),
      //       onPressed: (){
      //         Navigator.push(context,
      //           MaterialPageRoute(builder:(context)=>MapPage()),
      //         );
      //       },
      //     ),
      //   ),
      // ],)  ,
    );
  }
}




