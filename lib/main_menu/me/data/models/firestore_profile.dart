import '../../domain/models/profile.dart';
import 'firestore_tripboard.dart';

class ProfileFirestoreModel {
  final String uid;
  final String name;
  final String email;
  final List<String> savedIdPlaceList;
  final List<TripboardFirestoreModel> tripboardList;

  const ProfileFirestoreModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.savedIdPlaceList,
    required this.tripboardList,
  });

  /// Firestore -> Model
  factory ProfileFirestoreModel.fromJson(Map<String, dynamic> json) {
    return ProfileFirestoreModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      savedIdPlaceList: List<String>.from(json['savedIdPlaceList'] ?? []),
      tripboardList:
          (json['tripboardList'] as List<dynamic>? ?? [])
              .map((t) => TripboardFirestoreModel.fromJson(t))
              .toList(),
    );
  }

  /// Model -> Firestore
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'savedIdPlaceList': savedIdPlaceList,
      'tripboardList': tripboardList.map((t) => t.toJson()).toList(),
    };
  }

  /// Domain -> Firestore
  factory ProfileFirestoreModel.fromDomain(Profile profile) {
    return ProfileFirestoreModel(
      uid: profile.uid,
      name: profile.name,
      email: profile.email,
      savedIdPlaceList: profile.savedIdPlaceList,
      tripboardList:
          profile.tripboardList
              .map((t) => TripboardFirestoreModel.fromDomain(t))
              .toList(),
    );
  }

  /// Firestore -> Domain
  Profile toDomain() {
    return Profile(
      uid: uid,
      name: name,
      email: email,
      savedIdPlaceList: savedIdPlaceList,
      tripboardList: tripboardList.map((t) => t.toDomain()).toList(),
    );
  }
}
