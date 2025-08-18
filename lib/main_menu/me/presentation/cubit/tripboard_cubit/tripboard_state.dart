part of 'tripboard_cubit.dart';

sealed class TripboardState extends Equatable {
  const TripboardState();

  @override
  List<Object> get props => [];
}

final class TripboardInitial extends TripboardState {}

final class TripboardLoading extends TripboardState {}

final class TripboardError extends TripboardState {
  final String errMessage;

  const TripboardError(this.errMessage);
}

final class TripboardLoaded extends TripboardState {
  final List<Tripboard> tripboardList;

  const TripboardLoaded(this.tripboardList);
}

final class TripboardPlacesLoaded extends TripboardState {
  final Tripboard tripboard;

  const TripboardPlacesLoaded(this.tripboard);
}

final class TripboardSuccess extends TripboardState {
  final String tripboardId;

  const TripboardSuccess(this.tripboardId);
}
