import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:telusur_bogor/utils/scaffold_message.dart';

Future<List<LatLng>> fetchRoute(
  BuildContext context, {
  required double originLat,
  required double originLon,
  required double destinationLat,
  required double destinationLon,
}) async {
  final url = Uri.parse(
    'http://router.project-osrm.org/route/v1/driving/$originLon,$originLat;$destinationLon,$destinationLat?overview=full&geometries=polyline',
  );
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final geometry = data['routes'][0]['geometry'];
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPoints = polylinePoints.decodePolyline(geometry);

    final routeLatLng =
        decodedPoints
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
    return routeLatLng;
  } else {
    showErrorMessage(context, 'Failed to fetch route. Try again later');
    return [];
  }
}
