import '../../domain/models/tripboard.dart';

class TripboardFirestoreModel {
  final String id;
  final String name;
  final List<String> idPlaceList;

  TripboardFirestoreModel({
    required this.id,
    required this.name,
    required this.idPlaceList,
  });

  /// Firestore -> Model
  factory TripboardFirestoreModel.fromJson(Map<String, dynamic> json) {
    return TripboardFirestoreModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      idPlaceList: List<String>.from(json['idPlaceList'] ?? []),
    );
  }

  /// Model -> Firestore
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'idPlaceList': idPlaceList};
  }

  /// Domain -> Firestore
  factory TripboardFirestoreModel.fromDomain(Tripboard tripboard) {
    return TripboardFirestoreModel(
      id: tripboard.id,
      name: tripboard.name,
      idPlaceList: tripboard.idPlaceList,
    );
  }

  /// Firestore -> Domain
  Tripboard toDomain() {
    return Tripboard(id: id, name: name, idPlaceList: idPlaceList);
  }
}
