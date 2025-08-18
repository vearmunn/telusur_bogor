// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:telusur_bogor/main_menu/me/domain/models/tripboard.dart';
import 'package:telusur_bogor/main_menu/me/domain/repository/tripboard_repo.dart';

part 'tripboard_state.dart';

class TripboardCubit extends Cubit<TripboardState> {
  final TripboardRepo tripboardRepo;
  TripboardCubit(this.tripboardRepo) : super(TripboardInitial());

  void createNewTripboard(String name) async {
    try {
      emit(TripboardLoading());
      final tripboardId = await tripboardRepo.createTripboard(name: name);
      emit(TripboardSuccess(tripboardId));
    } catch (e) {
      emit(TripboardError(e.toString()));
    }
  }

  void addToTripboard({
    required String tripboardId,
    required String placeId,
  }) async {
    try {
      emit(TripboardLoading());
      await tripboardRepo.addPlaceToTripboard(
        tripboardId: tripboardId,
        placeId: placeId,
      );
      fetchAllTripboards();
    } catch (e) {
      emit(TripboardError(e.toString()));
    }
  }

  void removeFromTripboard({
    required String tripboardId,
    required String placeId,
  }) async {
    try {
      emit(TripboardLoading());
      await tripboardRepo.deletePlaceFromTripboard(
        tripboardId: tripboardId,
        placeId: placeId,
      );
      fetchTripboardPlaces(tripboardId);
    } catch (e) {
      emit(TripboardError(e.toString()));
    }
  }

  void fetchAllTripboards() async {
    try {
      emit(TripboardLoading());
      final allTripboards = await tripboardRepo.getAllTripboards();
      emit(TripboardLoaded(allTripboards));
    } catch (e) {
      emit(TripboardError(e.toString()));
    }
  }

  void fetchTripboardPlaces(String tripboardId) async {
    try {
      emit(TripboardLoading());
      final tripboard = await tripboardRepo.getTripboardPlaces(
        tripboardId: tripboardId,
      );
      emit(TripboardPlacesLoaded(tripboard));
    } catch (e) {
      emit(TripboardError(e.toString()));
    }
  }
}
