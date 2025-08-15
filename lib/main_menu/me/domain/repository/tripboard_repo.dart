import 'package:telusur_bogor/main_menu/me/domain/models/tripboard.dart';

import '../../../home/tempat/domain/models/place.dart';

abstract class TripboardRepo {
  Future createTripboard({required String uid, required String name});

  Future addPlaceToTripboard({
    required String uid,
    required String tripboardId,
    required String placeId,
  });

  Future deletePlaceFromTripboard({
    required String uid,
    required String tripboardId,
    required String placeId,
  });

  Future<List<Tripboard>> getAllTripboards(String uid);

  Future<List<Place>> getTripboardPlaces({
    required String uid,
    required String tripboardId,
  });
}
