import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DrugDetail extends StatefulWidget {
  dynamic currentDrug;

  DrugDetail(dynamic drug) {
    currentDrug = drug;
  }

  @override
  _DrugDetailState createState() => _DrugDetailState(currentDrug);
}

class _DrugDetailState extends State<DrugDetail> {
  dynamic currentDrug;
  List<Text> tabInfos = [];
  int currentIndex = 0;

  _DrugDetailState(dynamic drug) {
    currentDrug = drug;
    tabInfos.add(Text(
      "\n"+currentDrug['description'],
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 16,
        color: Colors.white60,
        fontWeight: FontWeight.normal,
      ),
    ));
    tabInfos.add(Text(
      "\n"+currentDrug['precautions'],
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 16,
        color: Colors.white60,
        fontWeight: FontWeight.normal,
      ),
    ));
    tabInfos.add(Text(
      "\n"+currentDrug['pharmacy'],
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 16,
        color: Colors.white60,
        fontWeight: FontWeight.normal,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          child: Stack(
            children: <Widget>[
              Container(
                height: height * 0.55,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage("assets/images/${currentDrug["image"]}"),
                        fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.9),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                ),
              ),
              Container(
                width: width,
                margin: EdgeInsets.only(top: height * 0.5),
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: currentDrug['color'],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      currentDrug['name'],
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DefaultTabController(
                      length: 3,
                      child: Column(
                        children: <Widget>[
                          TabBar(
                            labelColor: Colors.white,
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            unselectedLabelColor: Colors.grey[400],
                            unselectedLabelStyle: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 15),
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: Colors.transparent,
                            indicator: UnderlineTabIndicator(),
                            onTap: (index) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            tabs: <Widget>[
                              Tab(
                                child: Text("Description"),
                              ),
                              Tab(
                                child: Text("Precaution"),
                              ),
                              Tab(
                                child: Text("Pharmacy"),
                              ),
                            ],
                          ),
                          tabInfos[currentIndex],
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Price",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "RM" + currentDrug['price'].toString(),
                              style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.orange[800],
                          padding: EdgeInsets.fromLTRB(35, 15, 35, 15),
                          child: Text(
                            "Add to cart",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 30,
                top: height * 0.05,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.keyboard_backspace,
                    size: 42,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
