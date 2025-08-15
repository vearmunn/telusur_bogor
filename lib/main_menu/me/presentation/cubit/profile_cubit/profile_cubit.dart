// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:telusur_bogor/main_menu/me/domain/models/profile.dart';
import 'package:telusur_bogor/main_menu/me/domain/repository/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  ProfileCubit(this.profileRepo) : super(ProfileInitial()) {
    loadProfile();
  }

  void loadProfile() async {
    try {
      emit(ProfileLoading());
      final profile = await profileRepo.getProfile();
      print(profile.savedIdPlaceList);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
