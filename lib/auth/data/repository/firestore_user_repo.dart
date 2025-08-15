import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:telusur_bogor/auth/domain/models/user.dart';
import 'package:telusur_bogor/auth/domain/repository/user_repo.dart';

import '../models/firestore_user.dart';

class FirestoreUserRepo implements UserRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<UserModel?> checkAuthStatus() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection("users").doc(user.uid).get();
      final data = doc.data() ?? {};
      final currentUser = FirestoreUser.fromMap(user.uid, data);
      return currentUser.toDomain();
    } else {
      return null;
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final newUser = FirestoreUser(
      uid: credential.user!.uid,
      name: name,
      email: email,
    );
    await _firestore.collection("users").doc(newUser.uid).set({
      ...newUser.toMap(),
      'savedIdPlaceList': [],
      'tripboardList': [],
    });

    return newUser.toDomain();
  }

  @override
  Future<UserModel> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final doc =
        await _firestore.collection("users").doc(credential.user!.uid).get();
    final data = doc.data() ?? {};

    final user = FirestoreUser.fromMap(credential.user!.uid, data);

    return user.toDomain();
  }

  @override
  Future logout() async {
    await _auth.signOut();
  }
}
