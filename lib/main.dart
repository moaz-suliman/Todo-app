import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/flutter_secure_storge.dart';
import 'package:todo_app/feature/HomePage/data/repository/todo_repository_impl.dart';
import 'package:todo_app/feature/HomePage/presintation/provider/todo_page_povider.dart';
import 'package:todo_app/feature/HomePage/presintation/view/todo_page_view.dart';
import 'package:todo_app/feature/auth/login/data/repository/user_repository_impl.dart';
import 'package:todo_app/feature/auth/login/presintation/provider/user_provider.dart';
import 'package:todo_app/feature/auth/login/presintation/view/login.dart';
import 'package:todo_app/feature/new_task.dart/presintation/provider/new_task_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repository = TodoRepositoryImpl();
  final userRepository = UserRepositoryImpl();
  final token = await SecureStorage().getToken();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NewTaskProvider(repository),
        ),
        ChangeNotifierProvider(
          create: (context) => TodoPagePovider(repository),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(userRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: token != null && token.isNotEmpty ? HomePageView() : LoginPage(),
      ),
    ),
  );
}
