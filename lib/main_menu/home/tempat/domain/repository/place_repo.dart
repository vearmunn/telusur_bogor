import '../models/place.dart';

abstract class PlaceRepo {
  Future addPlace(Place place);

  Future<Place?> getPlace(String id);

  Future<List<Place>> getPlaces({PlaceType? type, int? limit, String? tag});
}
