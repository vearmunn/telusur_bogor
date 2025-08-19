// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:telusur_bogor/main_menu/map/domain/models/map_marker.dart';
import 'package:telusur_bogor/main_menu/map/domain/repository/map_marker_repo.dart';

part 'map_marker_state.dart';

class MapMarkerCubit extends Cubit<MapMarkerState> {
  final MapMarkerRepo markerRepo;
  MapMarkerCubit(this.markerRepo) : super(MapMarkerInitial());

  void loadMapMarkers() async {
    try {
      emit(MapMarkerLoading());
      final markers = await markerRepo.loadMapMarkers();
      emit(MapMarkerLoaded(markers));
    } catch (e) {
      emit(MapMarkerError(e.toString()));
    }
  }
}
