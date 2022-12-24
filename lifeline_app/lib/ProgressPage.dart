


import 'package:lifeline_app/MapPage.dart';

import 'CircleProgress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'main.dart' as main;



class ProgressPage extends StatefulWidget {
  ProgressPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProgressPage createState() => _ProgressPage();
}

class _ProgressPage extends State<ProgressPage> with SingleTickerProviderStateMixin {
  AnimationController progressController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    progressController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 7000));
    animation = Tween<double>(begin: 100, end: 0).animate(progressController)
      ..addListener(() {
        setState(() {
          if (animation.value >0 && animation.value<0.5){
            print("here");
            progressController.stop();
            Navigator.push(context,
              MaterialPageRoute(builder:(context)=>MapPage()),
            );
          }
        });
      });
    progressController.repeat();
    // }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Lifeline"),
      ),
        backgroundColor: Colors.white,
        body:Stack(
          children: [
            Positioned(
              top:200,
              left:100,
              child: CustomPaint(
                foregroundPainter: CircleProgress(animation.value),
                child: Container(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(value:animation.value,backgroundColor: Colors.white,strokeWidth:0.00,),
                    color:Colors.white
                ),
              )
            ),
            Positioned(
              top:290,
              left:170,
              child:Text("${(animation.value.toInt()/10).toInt()} seconds")

            ),
            Positioned(
              bottom:160,
              left:155,
              child:FlatButton(
                child: Text("Cancel"),
                color: Colors.blue,
                onPressed:(){
                  Navigator.pop(context,false);
                },
              )
            )
          ],
        )

    );
  }
}