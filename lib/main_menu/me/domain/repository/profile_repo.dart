import '../models/profile.dart';

abstract class ProfileRepo {
  Future<Profile> getProfile();
}
