import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatelessWidget {
  static const routeName = '/LocationScreen';

  @override
  Widget build(BuildContext context) {
    final LatLng location = ModalRoute.of(context)!.settings.arguments as LatLng;

    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Location'),
      ),
      body: Center(
        child: Text('Latitude: ${location.latitude}, Longitude: ${location.longitude}'),
      ),
    );
  }
}
