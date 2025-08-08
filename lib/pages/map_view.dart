import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import '../utils/scaffold_message.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  LatLng? _currentLatLng;
  final Location _location = Location();
  final TextEditingController _textLocationController = TextEditingController();
  bool isLoading = false;
  LatLng? _destinationLatLng;
  List<LatLng> routeLatLng = [];

  Future _initializeLocation() async {
    if (!await _checkRequestPermission()) return;

    _getCurrentLocation();
  }

  Future<bool> _checkRequestPermission() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return false;
    }

    // check if location permissions are granted
    PermissionStatus permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) return false;
    }
    return true;
  }

  Future _getCurrentLocation() async {
    final position = await geo.Geolocator.getCurrentPosition(
      locationSettings: geo.LocationSettings(
        accuracy: geo.LocationAccuracy.best,
      ),
    );

    setState(() {
      _currentLatLng = LatLng(position.latitude, position.longitude);
      _mapController.move(_currentLatLng!, 14);
    });
  }

  Future _fetchCoordinatePoints(String location) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$location&format=json&limit=1',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data.isNotEmpty) {
        final lat = double.parse(data[0]['lat']);
        final lon = double.parse(data[0]['lon']);
        setState(() {
          _destinationLatLng = LatLng(lat, lon);
        });
        await _fetchRoute();
      } else {
        showErrorMessage(context, 'Location not found. Please try again');
      }
    } else {
      showErrorMessage(context, 'Failed to fetch location. Try again later');
    }
  }

  Future _fetchRoute() async {
    if (_currentLatLng == null || _destinationLatLng == null) return;
    final url = Uri.parse(
      'http://router.project-osrm.org/route/v1/driving/${_currentLatLng!.longitude},${_currentLatLng!.latitude};${_destinationLatLng!.longitude},${_destinationLatLng!.latitude}?overview=full&geometries=polyline',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final geometry = data['routes'][0]['geometry'];
      _decodePolyline(geometry);
    } else {
      showErrorMessage(context, 'Failed to fetch route. Try again later');
    }
  }

  void _decodePolyline(String encodedPolyline) {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPoints = polylinePoints.decodePolyline(
      encodedPolyline,
    );

    setState(() {
      routeLatLng =
          decodedPoints
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();
    });
  }

  @override
  void initState() {
    _initializeLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OpenStreetMap')),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLatLng ?? LatLng(0, 0),
              initialZoom: 2,
              minZoom: 0,
              maxZoom: 100,
            ),
            children: [
              TileLayer(
                // urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                urlTemplate:
                    "https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=ChX0SylTxwIcoIr5Vid2",
              ),
              CurrentLocationLayer(
                style: LocationMarkerStyle(
                  marker: DefaultLocationMarker(
                    child: Icon(Icons.location_pin, color: Colors.white),
                  ),
                  markerSize: Size(35, 35),
                  markerDirection: MarkerDirection.heading,
                ),
              ),
              if (_destinationLatLng != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _destinationLatLng!,
                      child: Icon(
                        Icons.location_pin,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              if (_currentLatLng != null &&
                  _destinationLatLng != null &&
                  routeLatLng.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routeLatLng,
                      strokeWidth: 5,
                      color: Colors.red,
                    ),
                  ],
                ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(controller: _textLocationController),
                  ),
                  IconButton(
                    onPressed: () {
                      final location = _textLocationController.text.trim();
                      if (location.isNotEmpty) {
                        _fetchCoordinatePoints(location);
                      }
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        child: Icon(Icons.location_searching),
      ),
    );
  }
}
