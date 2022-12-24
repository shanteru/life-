import 'package:flutter/material.dart';
//Reference NOTE: inspired from MJSD coding

class ProfilePage extends StatefulWidget {
  final String url;
  final String tisName;
  final String tisLocation;

  ProfilePage({@required this.url, this.tisName, this.tisLocation});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 35),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back_ios)),
                Icon(Icons.more_vert),
              ],
            ),
          ),
          Hero(
            tag: widget.url,
            child: Container(
              margin: EdgeInsets.only(top: 35),
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 20,
                  )
                ],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      widget.url),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.tisName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.tisLocation,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildStatColumn("53", "Photos"),
              buildStatColumn("223k", "Followers"),
              buildStatColumn("117", "Following"),
            ],
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 8, right: 8, top: 8),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.15),
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(25))),
              child: GridView.count(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 5 / 6,
                children: [
                  buildPictureCard(
                      "https://images.pexels.com/photos/3926133/pexels-photo-3926133.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                  buildPictureCard(
                      "https://images.pexels.com/photos/2827263/pexels-photo-2827263.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                  buildPictureCard(
                      "https://images.pexels.com/photos/4281747/pexels-photo-4281747.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                  buildPictureCard(
                      "https://images.pexels.com/photos/772518/pexels-photo-772518.png?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                  buildPictureCard(
                      "https://images.pexels.com/photos/2089712/pexels-photo-2089712.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                  buildPictureCard(
                      "https://images.pexels.com/photos/4193842/pexels-photo-4193842.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),

                ],
              ),
            ),
          )
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 60,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.add,
            ),
            backgroundColor: Colors.grey[900],
            elevation: 15,
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.grey.withOpacity(0.1),
      //           spreadRadius: 1,
      //         )
      //       ],
      //       color: Colors.grey.withOpacity(0.2),
      //       borderRadius: BorderRadius.circular(15)),
      //   child: Row(
      //     children: [
      //       buildNavBarItem(Icons.home, 0),
      //       buildNavBarItem(Icons.search, 1),
      //       buildNavBarItem(null, -1),
      //       buildNavBarItem(Icons.notifications, 2),
      //       buildNavBarItem(Icons.person, 3),
      //     ],
      //   ),
      // ),
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        height: 45,
        child: icon != null
            ? Icon(
          icon,
          size: 25,
          color: index == _selectedItemIndex
              ? Colors.black
              : Colors.grey[700],
        )
            : Container(),
      ),
    );
  }

  Card buildPictureCard(String url) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(url),
            )),
      ),
    );
  }

  Column buildStatColumn(String value, String title) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }
}