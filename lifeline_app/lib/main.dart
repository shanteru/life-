import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lifeline_app/LoginPage.dart';
import 'package:provider/provider.dart';
import 'PharmacyPage.dart';
import 'DieticianPage.dart';
import 'HomePage.dart';
import 'SocialPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currIndex = 0;
  final List<Widget> _children = [
    HomePage(
      title: 'Home Page',
    ),
    PharmacyPage(
      title: 'Pharmacy Page',
    ),
    DieticianPage(title: 'Dietician Page'),
    SocialPage(title: 'Social Page'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor:  Color.fromRGBO(35, 77, 135,1.0),

      ),
      body: _children[currIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)) ,
        child: BottomNavigationBar(
          iconSize: 30,
          selectedIconTheme: IconThemeData(
            color: Color.fromRGBO(35, 77, 135,1.0),
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.black12,
          ),
          currentIndex: currIndex,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Icon(Icons.home),
              ),
              title: Text(
                "Home",
                style: const TextStyle(color: Colors.blueGrey),
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                child: Icon(Icons.shopping_cart),
                padding: const EdgeInsets.only(top: 8.0),
              ),
              title: Text(
                "Pharmacy",
                style: const TextStyle(color: Colors.blueGrey),
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                child: Icon(Icons.restaurant),
                padding: const EdgeInsets.only(top: 8.0),
              ),
              title: Text(
                "Diet Diary",
                style: const TextStyle(color: Colors.blueGrey),
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                child: Icon(Icons.workspaces_filled),
                padding: const EdgeInsets.only(top: 8.0),
              ),
              title: Text(
                "LifePods",
                style: const TextStyle(color: Colors.blueGrey),
              ),
            ),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.home),
            //     title: Text('Home'),
            //     backgroundColor: Colors.blue),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.shopping_cart),
            //     title: Text('Pharmacy'),
            //     backgroundColor: Colors.blue),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.restaurant),
            //     title: Text('Dietician'),
            //     backgroundColor: Colors.blue),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.workspaces_filled),
            //     title: Text('LifePods', style: const TextStyle(color: Colors.blueGrey),),
            //     backgroundColor: Colors.white)
          ],
          onTap: (index) {
            setState(() {
              currIndex = index;
            });
          },
      )


      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
