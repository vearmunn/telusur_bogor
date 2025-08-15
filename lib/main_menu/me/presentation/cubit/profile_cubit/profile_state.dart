part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final Profile profile;

  const ProfileLoaded(this.profile);
}

final class ProfileError extends ProfileState {
  final String errMessage;

  const ProfileError(this.errMessage);
}
