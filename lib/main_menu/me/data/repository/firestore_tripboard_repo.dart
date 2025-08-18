import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:telusur_bogor/main_menu/home/tempat/domain/models/place.dart';
import 'package:telusur_bogor/main_menu/me/data/models/firestore_tripboard.dart';
import 'package:telusur_bogor/main_menu/me/domain/models/tripboard.dart';
import 'package:telusur_bogor/main_menu/me/domain/repository/tripboard_repo.dart';

import '../../../home/tempat/data/model/firestore_place.dart';
import '../models/firestore_profile.dart';

class FirestoreTripboardRepo implements TripboardRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  @override
  Future addPlaceToTripboard({
    required String tripboardId,
    required String placeId,
  }) async {
    final userRef = _firestore.collection('users').doc(user!.uid);
    final snapshot = await userRef.get();

    if (!snapshot.exists) return;

    final profile = ProfileFirestoreModel.fromJson(snapshot.data()!);

    final updatedTripboards =
        profile.tripboardList.map((t) {
          if (t.id == tripboardId && !t.idPlaceList.contains(placeId)) {
            return TripboardFirestoreModel(
              id: t.id,
              name: t.name,
              idPlaceList: [...t.idPlaceList, placeId],
            );
          }
          return t;
        }).toList();

    await userRef.update({
      "tripboardList": updatedTripboards.map((t) => t.toJson()).toList(),
    });
  }

  @override
  Future<String> createTripboard({required String name}) async {
    final userRef = _firestore.collection('users').doc(user!.uid);

    final tripboardId = FirebaseFirestore.instance.collection('users').doc().id;

    final newTripboard = TripboardFirestoreModel(
      id: tripboardId,
      name: name,
      idPlaceList: [],
    );

    await userRef.update({
      "tripboardList": FieldValue.arrayUnion([newTripboard.toJson()]),
    });

    return tripboardId;
  }

  @override
  Future deletePlaceFromTripboard({
    required String tripboardId,
    required String placeId,
  }) async {
    final userRef = _firestore.collection('users').doc(user!.uid);

    final snapshot = await userRef.get();
    if (!snapshot.exists) return;

    final profile = ProfileFirestoreModel.fromJson(snapshot.data()!);

    final updatedTripboards =
        profile.tripboardList.map((t) {
          if (t.id == tripboardId) {
            return TripboardFirestoreModel(
              id: t.id,
              name: t.name,
              idPlaceList: t.idPlaceList.where((id) => id != placeId).toList(),
            );
          }
          return t;
        }).toList();

    await userRef.update({
      "tripboardList": updatedTripboards.map((t) => t.toJson()).toList(),
    });
  }

  @override
  Future<List<Tripboard>> getAllTripboards() async {
    final userRef = _firestore.collection('users').doc(user!.uid);

    final snapshot = await userRef.get();
    if (!snapshot.exists) return [];

    final profile = ProfileFirestoreModel.fromJson(snapshot.data()!);

    List<Tripboard> tripboards =
        profile.tripboardList.map((tripboard) => tripboard.toDomain()).toList();

    // images for image collage per tripboard
    for (var tripboard in tripboards) {
      if (tripboard.idPlaceList.isNotEmpty) {
        final querySnap =
            await FirebaseFirestore.instance
                .collection('places')
                .where(FieldPath.documentId, whereIn: tripboard.idPlaceList)
                .get();
        for (var doc in querySnap.docs) {
          final data = doc.data();
          final List<dynamic> images = data['images'] ?? [];
          if (images.isNotEmpty) {
            final firstImage = images.first;
            tripboard.imgUrlList!.add(firstImage);
          }
        }
      }
    }

    return tripboards;
  }

  @override
  Future<Tripboard> getTripboardPlaces({required String tripboardId}) async {
    final userRef = _firestore.collection('users').doc(user!.uid);

    final snapshot = await userRef.get();
    // if (!snapshot.exists) return ;

    final profile = ProfileFirestoreModel.fromJson(snapshot.data()!);

    final tripboard = profile.tripboardList.singleWhere(
      (tripboard) => tripboard.id == tripboardId,
    );

    if (tripboard.idPlaceList.isNotEmpty) {
      final placeQuery =
          await FirebaseFirestore.instance
              .collection('places')
              .where(FieldPath.documentId, whereIn: tripboard.idPlaceList)
              .get();

      List<Place> places =
          placeQuery.docs
              .map((doc) => FirestorePlace.fromDocument(doc).toDomain())
              .toList();

      final userTripboard = Tripboard(
        id: tripboard.id,
        name: tripboard.name,
        idPlaceList: [],
        places: places,
      );

      return userTripboard;
    } else {
      return Tripboard(
        id: tripboard.id,
        name: tripboard.name,
        idPlaceList: [],
        places: [],
      );
    }
  }
}
