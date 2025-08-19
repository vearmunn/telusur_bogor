import 'dart:convert';

import 'package:telusur_bogor/main_menu/map/data/models/json_map_marker.dart';
import 'package:telusur_bogor/main_menu/map/domain/models/map_marker.dart';
import 'package:telusur_bogor/main_menu/map/domain/repository/map_marker_repo.dart';
import 'package:flutter/services.dart' show rootBundle;

class JsonMapMarkerRepo implements MapMarkerRepo {
  @override
  Future<List<MapMarker>> loadMapMarkers() async {
    final String response = await rootBundle.loadString(
      'assets/dummy_data.json',
    );
    final data = json.decode(response) as Map<String, dynamic>;
    final elements = data['elements'] as List<dynamic>;

    return elements.map((e) => JsonMapMarker.fromJson(e).toDomain()).toList();
  }
}
