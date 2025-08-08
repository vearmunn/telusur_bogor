class LatLngPoint {
  final double latitude;
  final double longitude;

  LatLngPoint({required this.latitude, required this.longitude});
}

class AngkotRoute {
  final String route;
  final String code;
  final double originLat;
  final double originLon;
  final double destinationLat;
  final double destinationLon;
  final List<LatLngPoint>? waypoints;

  AngkotRoute({
    required this.route,
    required this.code,
    required this.originLat,
    required this.originLon,
    required this.destinationLat,
    required this.destinationLon,
    this.waypoints,
  });
}

final List<AngkotRoute> angkotRoutes = [
  // AngkotRoute(
  //   route: "Ciawi-Baranangsiang",
  //   code: "21 AK",
  //   originLat: -6.655888120416776,
  //   originLon: 106.84721326741516,
  //   destinationLat: -6.655888120416776,
  //   destinationLon: 106.84721326741516,
  //   waypoints: null,
  // ),
  AngkotRoute(
    route: "Cicurug",
    code: "02",
    originLat: -6.620961222017755,
    originLon: 106.81611037487693,
    destinationLat: -6.782902171508681,
    destinationLon: 106.78210744371597,
    waypoints: null,
  ),
  AngkotRoute(
    route: "Cisarua",
    code: "02A",
    originLat: -6.620999082090449,
    originLon: 106.81622409150106,
    destinationLat: -6.700273761900149,
    destinationLon: 106.99007195694412,
    waypoints: null,
  ),
  AngkotRoute(
    route: "Cibedug",
    code: "02B",
    originLat: -6.620999082090449,
    originLon: 106.81622409150106,
    destinationLat: -6.69154397042773,
    destinationLon: 106.88339160324244,
    waypoints: null,
  ),
];
