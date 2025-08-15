// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'tripboard.dart';

class Profile {
  final String uid;
  final String name;
  final String email;
  final List<String> savedIdPlaceList;
  final List<Tripboard> tripboardList;

  const Profile({
    required this.uid,
    required this.name,
    required this.email,
    required this.savedIdPlaceList,
    required this.tripboardList,
  });
}
