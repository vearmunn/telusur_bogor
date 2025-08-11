import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telusur_bogor/main_menu/home/tempat/data/model/firestore_place.dart';
import 'package:telusur_bogor/main_menu/home/tempat/domain/models/place.dart';
import 'package:telusur_bogor/main_menu/home/tempat/domain/repository/place_repo.dart';

class FirestorePlaceRepo implements PlaceRepo {
  final placesRef = FirebaseFirestore.instance.collection('places');
  @override
  Future addPlace(Place place) async {
    await placesRef.doc(place.id).set(FirestorePlace.fromDomain(place).toMap());
  }

  @override
  Future<Place?> getPlace(String id) async {
    final doc = await placesRef.doc(id).get();
    if (doc.exists) {
      return FirestorePlace.fromDocument(doc).toDomain();
    }
    return null;
  }

  @override
  Future<List<Place>> getPlaces({
    PlaceType? type,
    int? limit,
    String? tag,
  }) async {
    Query query = placesRef;

    // Filter if type is provided
    if (type != null) {
      query = query.where('type', isEqualTo: type.name);
    }

    // Filter if tag is provided
    if (tag != null) {
      query = query.where('tag', isEqualTo: tag);
    }

    // Apply limit if provided
    if (limit != null && limit > 0) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();

    return snapshot.docs
        .map((doc) => FirestorePlace.fromDocument(doc).toDomain())
        .toList();
  }
}
