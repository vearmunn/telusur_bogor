part of 'tempat_cubit.dart';

sealed class TempatState {}

final class TempatInitial extends TempatState {}

final class TempatLoading extends TempatState {}

final class ListTempatLoaded extends TempatState {
  final List<Place>? popularPlaceList;
  final List<Place>? nearMePlaceList;
  final List<Place>? hiddenGemPlaceList;
  final List<Place>? urgentPlaceList;

  ListTempatLoaded({
    this.popularPlaceList,
    this.nearMePlaceList,
    this.hiddenGemPlaceList,
    this.urgentPlaceList,
  });
}

final class TempatError extends TempatState {
  final String errMessage;

  TempatError(this.errMessage);
}
