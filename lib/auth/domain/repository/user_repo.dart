import 'package:telusur_bogor/auth/domain/models/user.dart';

abstract class UserRepo {
  Future<UserModel> login(String email, String password);

  Future<UserModel> register(String name, String email, String password);

  Future logout();

  Future<UserModel?> checkAuthStatus();
}
