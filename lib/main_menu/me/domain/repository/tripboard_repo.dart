import 'package:telusur_bogor/main_menu/me/domain/models/tripboard.dart';

abstract class TripboardRepo {
  Future<String> createTripboard({required String name});

  Future addPlaceToTripboard({
    required String tripboardId,
    required String placeId,
  });

  Future deletePlaceFromTripboard({
    required String tripboardId,
    required String placeId,
  });

  Future<List<Tripboard>> getAllTripboards();

  Future<Tripboard> getTripboardPlaces({required String tripboardId});
}
