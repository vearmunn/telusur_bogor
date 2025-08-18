import '../../../home/tempat/domain/models/place.dart';

class Tripboard {
  final String id;
  final String name;
  final List<String> idPlaceList;
  final List<Place> places;
  final List<String>? imgUrlList;

  Tripboard({
    required this.id,
    required this.name,
    required this.idPlaceList,
    required this.places,
    this.imgUrlList,
  });
}
