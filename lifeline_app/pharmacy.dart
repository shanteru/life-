import 'package:flutter/material.dart';

class PharmacyPage extends StatefulWidget {
  PharmacyPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PharmacyPageState createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pharmacy'),
        ),
        body: Center(
          child: new Text("Pharmacy Page To Be")
        ),
    );
  }
}
