// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:telusur_bogor/auth/domain/repository/user_repo.dart';

import '../../domain/models/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepo userRepo;
  AuthCubit(this.userRepo) : super(AuthInitial()) {
    checkAuthStatus();
  }

  Future register(String name, String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await userRepo.register(name, email, password);
      emit(AuthAuthenticated(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Registration failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await userRepo.login(email, password);
      emit(AuthAuthenticated(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Registration failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future logout() async {
    await userRepo.logout();
    emit(AuthLoggedOut());
  }

  Future checkAuthStatus() async {
    emit(AuthLoading());
    final currentUser = await userRepo.checkAuthStatus();
    if (currentUser != null) {
      emit(AuthAuthenticated(currentUser));
    } else {
      emit(AuthLoggedOut());
    }
  }
}
