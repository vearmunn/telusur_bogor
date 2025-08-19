import '../../domain/models/map_marker.dart';

class JsonMapMarker {
  final int id;
  final double lat;
  final double lon;
  final String? name;
  final String? tourism;
  final String? amenity;

  JsonMapMarker({
    required this.id,
    required this.lat,
    required this.lon,
    this.name,
    this.tourism,
    this.amenity,
  });

  factory JsonMapMarker.fromJson(Map<String, dynamic> json) {
    final tags = json['tags'] as Map<String, dynamic>? ?? {};
    return JsonMapMarker(
      id: json['id'] as int,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      name: tags['name'] as String?,
      tourism: tags['tourism'] as String?,
      amenity: tags['amenity'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lat': lat,
      'lon': lon,
      'name': name,
      'tourism': tourism,
      'amenity': amenity,
    };
  }

  factory JsonMapMarker.fromDomain(MapMarker place) {
    return JsonMapMarker(
      id: place.id,
      lat: place.lat,
      lon: place.lon,
      name: place.name,
      tourism: place.tourism,
      amenity: place.amenity,
    );
  }

  MapMarker toDomain() {
    return MapMarker(
      id: id,
      lat: lat,
      lon: lon,
      name: name,
      tourism: tourism,
      amenity: amenity,
    );
  }
}
