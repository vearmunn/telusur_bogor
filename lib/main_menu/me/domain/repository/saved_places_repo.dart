import '../../../home/tempat/domain/models/place.dart';

abstract class SavedPlacesRepo {
  Future addPlace({required String uid, required String placeId});

  Future deletePlace({required String uid, required String placeId});

  Future<List<Place>> getSavedPlaces(String uid);
}
