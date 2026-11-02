import 'package:todo_app/feature/auth/login/data/model/user_model.dart';

abstract class UserRepository {
  Future<UserModel> logIn({
    required String email,
    required String password,
  });

  Future<UserModel> signUp({
    required String username,
    required String email,
    required String password,
  });

  Future<void> logOut();
}