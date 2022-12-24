import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'package:geocoder/geocoder.dart' as geocoder;
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';


class MapPage extends StatefulWidget {
  MapPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MapPage createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  FirebaseFirestore firestore= FirebaseFirestore.instance;
  Geoflutterfire geo= Geoflutterfire();
  Location location= new Location();
  Set<Marker> _markers = Set<Marker>();
  BehaviorSubject<double> radius = BehaviorSubject<double>.seeded(100.0);
  Stream<dynamic> query;
  StreamSubscription subscription;
  BitmapDescriptor humanIcon;

  void _animateToUser () async{
    LocationData pos= await location.getLocation();
    print(pos.latitude);
    print(pos.longitude);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(pos.latitude, pos.longitude),
      zoom: 14.0,)));
    print(_controller);

  }
  Future<ui.Image> getImageFromPath(String imagePath) async {
    File imageFile = File(imagePath);

    Uint8List imageBytes = imageFile.readAsBytesSync();

    final Completer<ui.Image> completer = new Completer();

    ui.decodeImageFromList(imageBytes, (ui.Image img) {
      return completer.complete(img);
    });

    return completer.future;
  }

  Future<BitmapDescriptor> getMarkerIcon(String imagePath, Size size) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Radius radius = Radius.circular(size.width / 2);

    final Paint tagPaint = Paint()..color = Colors.blue;
    final double tagWidth = 40.0;

    final Paint shadowPaint = Paint()..color = Colors.blue.withAlpha(100);
    final double shadowWidth = 15.0;

    final Paint borderPaint = Paint()..color = Colors.white;
    final double borderWidth = 3.0;

    final double imageOffset = shadowWidth + borderWidth;

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              0.0,
              0.0,
              size.width,
              size.height
          ),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint);

    // Add border circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              shadowWidth,
              shadowWidth,
              size.width - (shadowWidth * 2),
              size.height - (shadowWidth * 2)
          ),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);

    // Add tag circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              size.width - tagWidth,
              0.0,
              tagWidth,
              tagWidth
          ),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        tagPaint);

    // Add tag text
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: '1',
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    );

    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(
            size.width - tagWidth / 2 - textPainter.width / 2,
            tagWidth / 2 - textPainter.height / 2
        )
    );

    // Oval for the image
    Rect oval = Rect.fromLTWH(
        imageOffset,
        imageOffset,
        size.width - (imageOffset * 2),
        size.height - (imageOffset * 2)
    );

    // Add path for oval image
    canvas.clipPath(Path()
      ..addOval(oval));

    // Add image
    ui.Image image = await getImageFromPath(imagePath); // Alternatively use your own method to get the image
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(
        size.width.toInt(),
        size.height.toInt()
    );

    // Convert image to bytes
    final ByteData byteData = await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }


  void _updateMarker(List<DocumentSnapshot> documentList) async{
    var pos = await location.getLocation();
    double lat = pos.latitude;
    double lng = pos.longitude;



    // Make a referece to firestore
    var ref = firestore.collection('location');
    GeoFirePoint center = geo.point(latitude: lat, longitude: lng);

    print("WAAA");
    print(humanIcon);
    _markers.clear();
    documentList.forEach((DocumentSnapshot document) {

      GeoPoint geopoint= document.data()['position']['geopoint'];
      double distance = center.distance(lat: geopoint.latitude, lng: geopoint.longitude);

      setState((){
        _markers.add(Marker(
            markerId: MarkerId(document.id),
            position: LatLng(document.data()['position']['geopoint'].latitude, document.data()['position']['geopoint'].longitude),
            // icon: getMarkerIcon('assets/images/humanicon.png', Size(150.0, 150.0)),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: 'Magic Marker distance is $distance km from query center')
        ));
      });

    });

  }


  _startQuery() async {
    // Get users location
    var pos = await location.getLocation();
    double lat = pos.latitude;
    double lng = pos.longitude;

    // Make a referece to firestore
    var ref = firestore.collection('location');
    GeoFirePoint center = geo.point(latitude: lat, longitude: lng);
    // subscribe to query
    subscription = radius.switchMap((rad) {
      print(rad);
      return geo.collection(collectionRef: ref).within(
        center: center,
        radius: rad,
        field: 'position',
        strictMode: true,
      );
    }).listen(_updateMarker);
  }

  _updateQuery(value) async{
    print(value);
    final zoomMap= {
      100.0: 14.0,
      200.0: 16.0,
      300.0 : 18.0,
      400.0: 19.0,
      500.0: 20.0
    };
    final zoom= zoomMap[value];
    final GoogleMapController controller= await _controller.future;
    controller.moveCamera(CameraUpdate.zoomTo(zoom));

    setState(() {
      radius.add(value);
    });
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future<DocumentReference> _addGeoPoint() async{

    LocationData pos= await location.getLocation();
    GeoFirePoint point= geo.point(latitude: pos.latitude, longitude: pos.longitude);
    final coordinates = new geocoder.Coordinates(pos.latitude, pos.longitude);
    var addresses = await geocoder.Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(first.featureName);
    return firestore.collection('location').add({
      'position': point.data,
      'first aider location':first.featureName,
    });
  }


  @override
  void initState(){

    _animateToUser();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      home: Stack(
          children:
          [
            GoogleMap(
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: LatLng(2.1896, 102.2501),
                zoom: 14.0,
              ),

              myLocationEnabled: true,
              compassEnabled: true,
              onMapCreated: (GoogleMapController controller){
                _controller.complete(controller);
                _startQuery();

              },

            ),
            Positioned(
                bottom: 50,
                right: 10,
                child:
                FlatButton(
                    child: Icon(Icons.accessibility_sharp),
                    color: Colors.green,
                    onPressed: (){
                      _addGeoPoint();
                    }
                )
            ),
            Positioned(
                bottom: 10,
                right: 10,
                child:
                FlatButton(
                    child: Icon(Icons.local_hospital),
                    color: Colors.green,
                    onPressed: (){
                      _addGeoPoint();
                    }
                )
            ),
            Positioned(
                bottom: 50,
                left: 10,
                child: Material(
                    child: Slider(
                      min: 100.0,
                      max: 500.0,
                      divisions: 4,
                      value: radius.value,
                      label: 'Radius ${radius.value}km',
                      activeColor: Colors.green,
                      inactiveColor: Colors.green.withOpacity(0.2),
                      onChanged: _updateQuery,
                    )
                )
            )

          ]
      ),
    );
  }

}
