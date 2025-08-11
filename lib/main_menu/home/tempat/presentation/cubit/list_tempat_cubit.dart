// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/place.dart';
import '../../domain/repository/place_repo.dart';

part 'list_tempat_state.dart';

class ListTempatCubit extends Cubit<ListTempatState> {
  final PlaceRepo placeRepo;
  ListTempatCubit(this.placeRepo) : super(ListTempatInitial());

  Future getPlaces(String tag) async {
    emit(ListTempatLoading());
    try {
      final places = await placeRepo.getPlaces(tag: tag);
      emit(ListTempatLoaded(places));
    } catch (e) {
      emit(ListTempatError(e.toString()));
    }
  }
}
