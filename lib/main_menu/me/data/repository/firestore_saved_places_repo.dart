import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telusur_bogor/main_menu/home/tempat/data/model/firestore_place.dart';
import 'package:telusur_bogor/main_menu/home/tempat/domain/models/place.dart';
import 'package:telusur_bogor/main_menu/me/domain/repository/saved_places_repo.dart';

import '../models/firestore_profile.dart';

class FirestoreSavedPlacesRepo implements SavedPlacesRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future addPlace({required String uid, required String placeId}) async {
    final userRef = _firestore.collection('users').doc(uid);
    final snapshot = await userRef.get();

    if (!snapshot.exists) return;

    final profile = ProfileFirestoreModel.fromJson(snapshot.data()!);

    final updatedSavedPlaces = [...profile.savedIdPlaceList, placeId];
    await userRef.update({"savedIdPlaceList": updatedSavedPlaces});
  }

  @override
  Future deletePlace({required String uid, required String placeId}) async {
    final userRef = _firestore.collection('users').doc(uid);
    final snapshot = await userRef.get();

    if (!snapshot.exists) return;

    final profile = ProfileFirestoreModel.fromJson(snapshot.data()!);

    final updatedSavedPlaces = profile.savedIdPlaceList.where(
      (id) => id != placeId,
    );
    await userRef.update({"savedIdPlaceList": updatedSavedPlaces});
  }

  @override
  Future<List<Place>> getSavedPlaces(String uid) async {
    if (uid.isEmpty) {
      throw ArgumentError("UID cannot be empty");
    }

    final snapshot = await _firestore.collection('users').doc(uid).get();

    final savedIds = List<String>.from(
      snapshot.data()?['savedIdPlaceList'] ?? [],
    );

    if (savedIds.isEmpty) return [];

    final placeQuery =
        await FirebaseFirestore.instance
            .collection('places')
            .where(FieldPath.documentId, whereIn: savedIds)
            .get();

    List<Place> places =
        placeQuery.docs
            .map((doc) => FirestorePlace.fromDocument(doc).toDomain())
            .toList();

    return places;
  }
}
