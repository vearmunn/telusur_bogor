class MapMarker {
  final int id;
  final double lat;
  final double lon;
  final String? name;
  final String? tourism;
  final String? amenity;

  MapMarker({
    required this.id,
    required this.lat,
    required this.lon,
    this.name,
    this.tourism,
    this.amenity,
  });
}
