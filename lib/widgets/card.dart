import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationCard extends StatelessWidget {
  final LatLng userLocation;
  final Function(GoogleMapController) onMapCreated;

  const LocationCard({
    super.key,
    required this.userLocation,
    required this.onMapCreated,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Titre + coordonnées
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Icon(Icons.map, color: Colors.blue),
                const SizedBox(width: 8),
                const Text(
                  'Localisation actuelle',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Lat: ${userLocation.latitude.toStringAsFixed(5)}'),
                    Text('Lng: ${userLocation.longitude.toStringAsFixed(5)}'),
                  ],
                ),
              ],
            ),
          ),
          // Carte Google Maps
          SizedBox(
            height: 300,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: userLocation,
                  zoom: 15,
                ),
                onMapCreated: onMapCreated,
                markers: {
                  Marker(
                    markerId: const MarkerId('me'),
                    position: userLocation,
                    infoWindow: const InfoWindow(title: 'Vous êtes ici'),
                  ),
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
