import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:telusur_bogor/main_menu/home/tempat/domain/models/place.dart';
import 'package:telusur_bogor/main_menu/map/presentation/cubit/map_marker_cubit/map_marker_cubit.dart';

import '../../../utils/fetch_route.dart';
import 'cubit/search_location_cubit/search_location_cubit.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  LatLng? _currentLatLng;
  final Location _location = Location();
  // bool isLoading = false;
  LatLng? _destinationLatLng;
  List<LatLng> routeLatLng = [];

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
              initialCenter: _currentLatLng ?? LatLng(-6.6, 106.8),
              initialZoom: 12,
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
              BlocBuilder<MapMarkerCubit, MapMarkerState>(
                builder: (context, state) {
                  if (state is MapMarkerLoaded) {
                    return MarkerLayer(
                      markers:
                          state.mapMarkerList
                              .map(
                                (place) => Marker(
                                  point: LatLng(place.lat, place.lon),
                                  child: GestureDetector(
                                    onTap:
                                        () => print(
                                          place.name ??
                                              place.amenity ??
                                              place.tourism,
                                        ),
                                  ),
                                ),
                              )
                              .toList(),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),

              if (routeLatLng.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routeLatLng,
                      strokeWidth: 5,
                      color: Colors.green,
                    ),
                  ],
                ),
              if (_destinationLatLng != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _destinationLatLng!,
                      child: Icon(
                        Icons.location_pin,
                        size: 40,
                        color: Colors.blue,
                      ),
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
              child: BlocBuilder<SearchCubit, List<Place>>(
                builder: (context, state) {
                  return TypeAheadField<Place>(
                    suggestionsCallback: (pattern) async {
                      await context.read<SearchCubit>().searchPlaces(pattern);
                      return context.read<SearchCubit>().state;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion.name),
                        subtitle: Text(
                          'Lat: ${suggestion.latitude} | Lon: ${suggestion.longitude}',
                        ),
                      );
                    },
                    onSelected: (suggestion) {
                      _getRoute(suggestion.latitude, suggestion.longitude);
                    },
                  );
                },
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

  Future _getRoute(double destinationLat, double destinationlon) async {
    final result = await fetchRoute(
      context,
      originLat: _currentLatLng!.latitude,
      originLon: _currentLatLng!.longitude,
      destinationLat: destinationLat,
      destinationLon: destinationlon,
    );

    if (result.isNotEmpty) {
      setState(() {
        routeLatLng = result;
        _destinationLatLng = LatLng(destinationLat, destinationlon);
      });

      final bounds = LatLngBounds.fromPoints(routeLatLng);
      _mapController.fitCamera(
        CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(40)),
      );
    } else {
      debugPrint("No points found");
    }
  }
}
