// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:telusur_bogor/main_menu/me/domain/repository/saved_places_repo.dart';

import '../../../../home/tempat/domain/models/place.dart';

part 'saved_places_state.dart';

class SavedPlacesCubit extends Cubit<SavedPlacesState> {
  final SavedPlacesRepo savedPlacesRepo;

  SavedPlacesCubit(this.savedPlacesRepo) : super(SavedPlacesInitial());

  Future addToSavedPlaces(String uid, String placeId) async {
    try {
      emit(SavedPlacesLoading());
      await savedPlacesRepo.addPlace(uid: uid, placeId: placeId);
      fetchSavedPlaces(uid);
    } catch (e) {
      emit(SavedPlacesError(e.toString()));
    }
  }

  Future removeFromSavedPlaces(String uid, String placeId) async {
    try {
      emit(SavedPlacesLoading());
      await savedPlacesRepo.deletePlace(uid: uid, placeId: placeId);
      fetchSavedPlaces(uid);
    } catch (e) {
      emit(SavedPlacesError(e.toString()));
    }
  }

  void fetchSavedPlaces(String uid) async {
    try {
      emit(SavedPlacesLoading());
      final places = await savedPlacesRepo.getSavedPlaces(uid);
      emit(SavedPlacesLoaded(places));
    } catch (e) {
      emit(SavedPlacesError(e.toString()));
    }
  }
}
