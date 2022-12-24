import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ProfilePage.dart';

class SocialPage extends StatefulWidget {
  SocialPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  SocialPageState createState() => SocialPageState();
}

class SocialPageState extends State<SocialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFE9E9E9),
      body: Container(
        padding: EdgeInsets.only(left:10, right:10, top:15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Instances',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey

              ),
            ),
            Container(
              margin: EdgeInsets.only(top:8, bottom: 12),
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=640"),

                      ),
                      Positioned(
                          bottom:0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 10,
                            child: Icon(Icons.add, size: 15
                            ),
                          ),
                      )
                    ],
                  ),



                  buildAvatarInstances("https://images.pexels.com/photos/5496586/pexels-photo-5496586.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                  buildAvatarInstances("https://images.pexels.com/photos/4343180/pexels-photo-4343180.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                  buildAvatarInstances("https://images.pexels.com/photos/4969986/pexels-photo-4969986.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                  buildAvatarInstances("https://images.pexels.com/photos/4993100/pexels-photo-4993100.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                  buildAvatarInstances("https://images.pexels.com/photos/4993100/pexels-photo-4993100.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),//add one more later for scrolling effect


                ],
              ),

            ),
            Container(
              height: 2,
              color: Colors.blueGrey[100],
              margin: EdgeInsets.symmetric(horizontal: 30),
            ),
            Expanded(child: ListView(
              padding: EdgeInsets.only(top: 8),
              children: [
                constructPostContent("https://images.pexels.com/photos/3926133/pexels-photo-3926133.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940", "https://images.pexels.com/photos/1898866/pexels-photo-1898866.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940", "UncleRoger", "Kuala Lumpur"),
                constructPostContent("https://images.pexels.com/photos/1234535/pexels-photo-1234535.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940", "https://images.pexels.com/photos/3229336/pexels-photo-3229336.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940", "Katlyn", "Penang"),
                // constructPostContent("", ""),
              ],
            ),
            )
          ],
        ),
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
            backgroundColor: Colors.blueGrey[900],
            elevation: 15,
          ),
        ),
      ),

    );
  }

  Container constructPostContent(String urlPost,String urlProfilePhoto,String name, String location) {
    return Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    constructPostFoundation(urlProfilePhoto, name, location),
                    SizedBox(height: 10,
                    ),
                    constructPost(urlPost),
                    SizedBox(height: 5,),
                    Text("998 likes",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                    ),
                    SizedBox(
                      height: 8,
                    )
                  ],
                ),
              );
  }

  Row constructPostFoundation(String urlProfilePhoto,String name, String location) {
    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[


                          GestureDetector(
                            onTap: (){ Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> ProfilePage(url: urlProfilePhoto, tisName: name, tisLocation: location,)));
                            },
                            child: Hero(
                            tag:urlProfilePhoto,
                            child: CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage(urlProfilePhoto),
                            ),
                            )

                          ),

                            SizedBox(width: 5,),
                            buildNameLocation(name,location),

                          ],
                        ),
                        Icon(Icons.more_vert)
                      ],
                    );
  }

  Column buildNameLocation(String name, String location) {
    return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name, style: TextStyle(fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              ),
                              Text(
                                location,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey),
                              )
                            ],
                          );
  }

  Stack constructPost(String urlPost) {
    return Stack(
                      children: [
                    Container(
                      height: MediaQuery.of(context).size.width-50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 20,
                            offset: Offset(0,10),
                          )
                        ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(urlPost)
                        )
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Icon(
                          Icons.favorite,
                          size: 35,
                          color: Colors.white.withOpacity(0.7)),
                    ),
                     ],
                    );
  }

  Container buildAvatarInstances(String url) {
    return Container(
                  margin: EdgeInsets.only(left: 18),
                  height: 60,
                  width:60,
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                      color: Colors.teal),

                  child: CircleAvatar(
                  radius: 10,
                    backgroundImage: NetworkImage(url),

                   ),
                );
  }
}