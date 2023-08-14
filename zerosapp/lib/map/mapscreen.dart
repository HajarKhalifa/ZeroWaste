import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zeros/map/location.dart';

class MapScreen extends StatefulWidget {
  static var routeName='/MapScreen';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;
  LatLng _initialCameraPosition = LatLng(37.7749, -122.4194);
  late LatLng _selectedLocation = LatLng(37.7749, -122.4194);


  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _initialCameraPosition =
          LatLng(position.latitude, position.longitude);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _onMapTap(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
  }
  void _saveLocation() {
    FirebaseFirestore.instance.collection('locations').add({
      'latitude': _selectedLocation.latitude,
      'longitude': _selectedLocation.longitude,
    });

    Navigator.of(context).pushNamed(
      LocationScreen.routeName,
      arguments: _selectedLocation,
    );
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialCameraPosition,
          zoom: 14,
        ),
        onMapCreated: _onMapCreated,
        onTap: _onMapTap,
        markers: _selectedLocation != null
            ? {
          Marker(
            markerId: MarkerId('selectedLocation'),
            position: _selectedLocation,
          )
        }
            : {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _selectedLocation != null ? _saveLocation : null,
        child: Icon(Icons.check),
      ),
    );
  }
}
