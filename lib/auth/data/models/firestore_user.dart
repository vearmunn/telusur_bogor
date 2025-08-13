import '../../domain/models/user.dart';

class FirestoreUser {
  final String uid;
  final String name;
  final String email;

  FirestoreUser({required this.uid, required this.name, required this.email});

  // Firestore → Model
  factory FirestoreUser.fromMap(String uid, Map<String, dynamic> data) {
    return FirestoreUser(
      uid: uid,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
    );
  }

  // Model → Firestore
  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email};
  }

  // Domain → Model
  factory FirestoreUser.fromDomain(UserModel user) {
    return FirestoreUser(uid: user.uid, name: user.name, email: user.email);
  }

  // Model → Domain
  UserModel toDomain() {
    return UserModel(uid: uid, name: name, email: email);
  }
}
