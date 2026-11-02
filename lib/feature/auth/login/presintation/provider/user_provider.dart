


import 'package:flutter/material.dart';
import 'package:todo_app/feature/HomePage/presintation/view/todo_page_view.dart';
import 'package:todo_app/feature/auth/login/data/model/user_model.dart';
import 'package:todo_app/feature/auth/login/data/repository/user_repository.dart';
import 'package:todo_app/feature/auth/login/presintation/view/login.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository repository;

  UserProvider(this.repository);

  bool isLoading = false;
  String error = '';
  UserModel? user;

  // Sign Up
Future<void> signUp({
  required BuildContext context,
  required String username,
  required String email,
  required String password,
}) async {
  isLoading = true;
  error = '';
  notifyListeners();

  try {
    user = await repository.signUp(
      username: username,
      email: email,
      password: password,
    );

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  } catch (e) {
    error = e.toString();
  }

  isLoading = false;
  notifyListeners();
}

  // Log In
  Future<void> logIn({
  required BuildContext context,
  required String email,
  required String password,
}) async {
  isLoading = true;
  error = '';
  notifyListeners();

  try {
    user = await repository.logIn(
      email: email,
      password: password,
    );

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePageView(),
      ),
    );
  } catch (e) {
    error = e.toString();
  }

  isLoading = false;
  notifyListeners();
}

  // Log Out
  Future<void> logOut(BuildContext context) async {
    isLoading = true;
    error = '';
    notifyListeners();

    try {
      await repository.logOut();
      user = null;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
