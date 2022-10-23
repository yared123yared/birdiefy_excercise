import 'package:app/Screen/dashboard/dashboard.dart';
import 'package:app/Screen/signup/signup.dart';
import 'package:app/Widget/button_widget.dart';
import 'package:app/Widget/textfield_widget.dart';
import 'package:app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:app/model/user_entity.dart';
import 'package:app/service/firebase_service.dart';

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  bool hasEmailError = false;
  bool hasPasswordError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            0, MediaQuery.of(context).size.height * 0.25, 0, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Container(
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          TextFieldWidget(
                            controller: _emailController,
                            focusNode: emailFocus,
                            nextFocus: passwordFocus,
                            maxLength: 30,
                            onFocusChange: (val) {
                              setState(() {});
                            },
                            onChanged: (String value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  hasEmailError = false;
                                });
                              }
                            },
                            title: 'Email',
                            hasError: hasEmailError,
                            // errorText: Validations.ADDRESS_FIRST_NAME_VALIDATION,
                            textInputType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                          ),
                          // const SizedBox(height: 0),
                          TextFieldWidget(
                            controller: _passwordController,
                            focusNode: passwordFocus,
                            nextFocus: FocusNode(),
                            maxLength: 30,
                            onFocusChange: (val) {
                              setState(() {});
                            },
                            onChanged: (String value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  hasEmailError = false;
                                });
                              }
                            },
                            title: 'Password',
                            hasError: hasPasswordError,
                            textInputType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ButtonWidget(
                      onPressed: () async {
                        try {
                          UserEntity user = await signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          print("User from: ${user.toJson()}");
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const DashboardPage()));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      },
                      text: 'Login')
                ],
              ),
            ),
            Column(
              children: [
                const Text(
                  "Don't have an account yet?",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUpView())),
                    child: const Text(
                      "Register here",
                      style: TextStyle(color: AppTheme.primaryColor),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
