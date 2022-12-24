import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CircleProgress extends CustomPainter{
  double currentProgress;
  CircleProgress(this.currentProgress);
  @override
  void paint(Canvas canvas, Size size) {

    Paint outerCircle= Paint()
      ..strokeWidth= 4
      ..color=Colors.white
      ..style = PaintingStyle.stroke;

    Paint completeArc= Paint()
      ..strokeWidth = 4
      ..color = Colors.redAccent
      ..style = PaintingStyle.stroke
      ..strokeCap= StrokeCap.round;

    Offset centre = Offset(size.width/2,size.height/2);
    double radius= min(size.width/2,size.height/2) - 7;

    canvas.drawCircle(centre, radius, outerCircle);// drawomg the main outer circle

    double angle= 2*pi*(currentProgress/100);
    canvas.drawArc(Rect.fromCircle(center: centre,radius:radius),-pi/2,angle,false,completeArc);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}