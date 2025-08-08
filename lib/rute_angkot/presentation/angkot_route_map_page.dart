// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:telusur_bogor/utils/fetch_route.dart';

class AngkotRouteMapPage extends StatefulWidget {
  const AngkotRouteMapPage({
    super.key,
    required this.originLat,
    required this.originLon,
    required this.destinationLat,
    required this.destinationLon,
    required this.route,
  });

  final double originLat;
  final double originLon;
  final double destinationLat;
  final double destinationLon;
  final String route;

  @override
  State<AngkotRouteMapPage> createState() => _AngkotRouteMapPageState();
}

class _AngkotRouteMapPageState extends State<AngkotRouteMapPage> {
  late MapController mapController;
  late LatLng origin;
  late LatLng destination;
  List<LatLng> routePoints = [];
  @override
  void initState() {
    mapController = MapController();
    origin = LatLng(widget.originLat, widget.originLon);
    destination = LatLng(widget.destinationLat, widget.destinationLon);
    _getRoute();
    super.initState();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  Future _getRoute() async {
    final result = await fetchRoute(
      context,
      originLat: widget.originLat,
      originLon: widget.originLon,
      destinationLat: widget.destinationLat,
      destinationLon: widget.destinationLon,
    );

    if (result.isNotEmpty) {
      setState(() {
        routePoints = result;
      });

      final bounds = LatLngBounds.fromPoints(routePoints);
      mapController.fitCamera(
        CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(40)),
      );
    } else {
      debugPrint("No points found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.route)),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              // initialCenter: _currentLatLng ?? LatLng(0, 0),
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
              MarkerLayer(
                markers: [
                  Marker(
                    point: origin,
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.location_on, color: Colors.green),
                  ),
                  Marker(
                    point: destination,
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.location_on, color: Colors.green),
                  ),
                ],
              ),
              if (routePoints.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routePoints,
                      strokeWidth: 4,
                      color: Colors.blue,
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
