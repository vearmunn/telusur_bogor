import 'package:telusur_bogor/main_menu/map/domain/models/map_marker.dart';

abstract class MapMarkerRepo {
  Future<List<MapMarker>> loadMapMarkers();
}
