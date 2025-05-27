import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: GeolocationAPP());
  }
}

class GeolocationAPP extends StatefulWidget {
  const GeolocationAPP({super.key});

  @override
  State<GeolocationAPP> createState() => _GeolocationAPPState();
}

class _GeolocationAPPState extends State<GeolocationAPP> {
  @override
  Widget build(BuildContext context) {
    Position? localisation_actuelle;
    late bool servicePermission;
    late LocationPermission permission;
    String adresse_actuelle = "";

    Future<Position> Affichage_localisation_actuelle() async {
      servicePermission = await Geolocator.isLocationServiceEnabled();
      if (!servicePermission) {
        print("votre service de localisation est désactivé");
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      return await Geolocator.getCurrentPosition();
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Latitude = ${localisation_actuelle?.latitude} ;Longitude= ${localisation_actuelle?.longitude} ",
            ),
            SizedBox(height: 7),
            Text(""),
            SizedBox(height: 7),
            ElevatedButton(
              onPressed: () async {
                localisation_actuelle = await Affichage_localisation_actuelle();
                setState(() {});
                print("${localisation_actuelle!.longitude}");
              },
              child: Text("affichage localisation"),
            ),
          ],
        ),
      ),
    );
  }
}
