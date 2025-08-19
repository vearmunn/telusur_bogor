part of 'map_marker_cubit.dart';

sealed class MapMarkerState extends Equatable {
  const MapMarkerState();

  @override
  List<Object> get props => [];
}

final class MapMarkerInitial extends MapMarkerState {}

final class MapMarkerLoading extends MapMarkerState {}

final class MapMarkerError extends MapMarkerState {
  final String errMessage;

  const MapMarkerError(this.errMessage);
}

final class MapMarkerLoaded extends MapMarkerState {
  final List<MapMarker> mapMarkerList;

  const MapMarkerLoaded(this.mapMarkerList);
}
