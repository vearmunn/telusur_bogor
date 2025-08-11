part of 'list_tempat_cubit.dart';

sealed class ListTempatState {}

final class ListTempatInitial extends ListTempatState {}

final class ListTempatLoading extends ListTempatState {}

final class ListTempatLoaded extends ListTempatState {
  final List<Place> placeList;

  ListTempatLoaded(this.placeList);
}

final class ListTempatError extends ListTempatState {
  final String errMessage;

  ListTempatError(this.errMessage);
}
