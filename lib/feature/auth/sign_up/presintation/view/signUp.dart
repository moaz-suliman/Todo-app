import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_color.dart';
import 'package:todo_app/core/custom_widget/app_button.dart';
import 'package:todo_app/core/custom_widget/textFormField.dart';
import 'package:todo_app/feature/auth/login/presintation/provider/user_provider.dart';
import 'package:todo_app/feature/auth/login/presintation/view/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                  Container(
                    width: 80,
                    height: 80,
                    child: Image.asset(
                      'assets/images/Taskly_Logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Create account',
                    style: GoogleFonts.inter(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Start organizing your day.',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: AppColor.secondryColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: 460,
                    height: 450,
                    child: Column(
                      children: [
                        TextformfieldWidget(
                          controller: nameController,
                          labelText: 'Full name',
                          hintText: 'Alex morgan',
                          icon: Icon(Icons.person_outline),
                        ),
                        SizedBox(height: 16),
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
                          hintText: 'Create a Strong Password',
                          icon: Icon(Icons.lock),
                        ),
                        Spacer(),
                        AppButton(
                          text: 'Create Account',
                          onPressed: () async {
                            await context.read<UserProvider>().signUp(
                              context: context,
                              username: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          },
                        ),
                        SizedBox(height: 8),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: GoogleFonts.inter(),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Log In',
                                  style: GoogleFonts.inter(
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
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
    );
  }
}
