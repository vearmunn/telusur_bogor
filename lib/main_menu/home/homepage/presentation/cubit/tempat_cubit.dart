// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../tempat/domain/models/place.dart';
import '../../../tempat/domain/repository/place_repo.dart';

part 'tempat_state.dart';

class TempatHomeCubit extends Cubit<TempatState> {
  final PlaceRepo placeRepo;
  TempatHomeCubit(this.placeRepo) : super(TempatInitial()) {
    fetchPlacesInHome();
  }

  // Future addPlace() async {
  //   try {
  //     emit(TempatLoading());
  //     for (var place in bogorPlaces) {
  //       await placeRepo.addPlace(place);
  //     }
  //     print('Done');
  //   } catch (e) {
  //     emit(TempatError(e.toString()));
  //   }
  // }

  Future fetchPlacesInHome() async {
    try {
      emit(TempatLoading());
      final popularPlaces = await placeRepo.getPlaces(limit: 3, tag: 'Popular');
      final nearMePlaces = await placeRepo.getPlaces(limit: 3, tag: 'Near Me');
      final hiddenGemPlaces = await placeRepo.getPlaces(
        limit: 3,
        tag: 'Hidden Gems',
      );
      final policePosts = await placeRepo.getPlaces(
        limit: 2,
        type: PlaceType.police,
      );
      final hospitals = await placeRepo.getPlaces(
        limit: 2,
        type: PlaceType.hospital,
      );

      List<Place> urgentPlaces = [];
      urgentPlaces.addAll(policePosts);
      urgentPlaces.addAll(hospitals);

      emit(
        ListTempatLoaded(
          popularPlaceList: popularPlaces,
          nearMePlaceList: nearMePlaces,
          hiddenGemPlaceList: hiddenGemPlaces,
          urgentPlaceList: urgentPlaces,
        ),
      );
    } catch (e) {
      emit(TempatError(e.toString()));
    }
  }
}
