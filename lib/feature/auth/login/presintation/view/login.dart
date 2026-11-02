
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_color.dart';
import 'package:todo_app/core/custom_widget/app_button.dart';
import 'package:todo_app/core/custom_widget/textFormField.dart';
import 'package:todo_app/feature/auth/login/presintation/provider/user_provider.dart';
import 'package:todo_app/feature/auth/sign_up/presintation/view/signUp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 40,
            right: 16,
            left: 16,
            bottom: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        child: Image.asset(
                          'assets/images/Taskly_Logo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Center(
                      child: Text(
                        'Welcome back',
                        style: GoogleFonts.inter(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: Text(
                        'Sign in to continue with your tasks and daily flow.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: AppColor.secondryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 360,
                      child: Column(
                        children: [
                          TextformfieldWidget(
                            controller: emailController,
                            
                            labelText: 'Email',
                            hintText: 'moaz@gmail.com',
                            icon: Icon(Icons.email_outlined),
                          ),
                          SizedBox(height: 16),
                          TextformfieldWidget(
                            controller: passwordController,
                            labelText: 'Password',
                            hintText: 'Choose Strong password',
                            icon: Icon(Icons.lock_outline),
                          ),
                          Spacer(),
                          AppButton(
                            text: 'Login',
                            onPressed: () {
                              context.read<UserProvider>().logIn(context: context,email: emailController.text, password: passwordController.text);
                             
                            },
                          ),
                          SizedBox(height: 8),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: GoogleFonts.inter(fontSize: 14),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUpPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: GoogleFonts.inter(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
