part of 'saved_places_cubit.dart';

sealed class SavedPlacesState extends Equatable {
  const SavedPlacesState();

  @override
  List<Object> get props => [];
}

final class SavedPlacesInitial extends SavedPlacesState {}

final class SavedPlacesLoading extends SavedPlacesState {}

final class SavedPlacesError extends SavedPlacesState {
  final String errMessage;

  const SavedPlacesError(this.errMessage);
}

final class SavedPlacesLoaded extends SavedPlacesState {
  final List<Place> places;

  const SavedPlacesLoaded(this.places);
}
