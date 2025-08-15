import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:telusur_bogor/main_menu/me/domain/models/profile.dart';
import 'package:telusur_bogor/main_menu/me/domain/repository/profile_repo.dart';

import '../models/firestore_profile.dart';

class FirestoreProfileRepo implements ProfileRepo {
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<Profile> getProfile() async {
    final userRef = _firestore.collection('users').doc(user!.uid);

    final snapshot = await userRef.get();

    final profile =
        ProfileFirestoreModel.fromJson({
          ...snapshot.data()!,
          'uid': user!.uid,
        }).toDomain();

    return profile;
  }
}
