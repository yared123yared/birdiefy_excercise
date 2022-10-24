library auth_service;

import 'package:app/Screen/login/login.dart';
import 'package:app/Widget/textfield_widget.dart';
import 'package:app/model/user_entity.dart';
import 'package:app/service/firebase_service.dart';
import 'package:app/utils/app_theme.dart';
import 'package:flutter/material.dart';

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _confirmPasswordController =
    TextEditingController();
final TextEditingController _firstNameController = TextEditingController();
final TextEditingController _lastNameController = TextEditingController();
final TextEditingController _handicapController = TextEditingController();

class SignUpView extends StatefulWidget {
  @override
  State<SignUpView> createState() => _SignUpViewState();
}

enum Role { Player, Coach }

class _SignUpViewState extends State<SignUpView> {
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPassFocus = FocusNode();
  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode handicapFocus = FocusNode();

  bool hasEmailError = false;
  bool hasPasswordError = false;
  bool hasConfiermPasswordError = false;
  bool hasFirstNameError = false;
  bool hasLastNameError = false;
  bool hasHandicapError = false;
  bool obscureText1 = true;
  bool obscureText2 = true;
  Role currentRole = Role.Player;
  bool isLoading = false;

  Widget _buildCreateAccount() {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith((states) {
          return const EdgeInsets.symmetric(horizontal: 50, vertical: 12);
        }),
        shape: MaterialStateProperty.resolveWith((states) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          );
        }),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          // If the button is pressed, return green, otherwise blue
          if (states.contains(MaterialState.pressed)) {
            return AppTheme.primaryColor;
          }
          return AppTheme.primaryColor;
        }),
      ),
      onPressed: () async {
        setState(() {
          isLoading = true;
        });
        if (_confirmPasswordController.text != _passwordController.text) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Password didn't match"),
            ),
          );
        } else {
          UserEntity userEntity = UserEntity(
              password: _passwordController.text,
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              email: _emailController.text,
              handicap: _handicapController.text,
              role: Role.Player.toString());
          try {
            await createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text,
                userEntity: userEntity);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginView()));
          } catch (e) {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
              ),
            );
          }
        }
      },
      child: Text(
        'Create Account',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 13),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      Center(
                        child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                              TextFieldWidget(
                                controller: _passwordController,
                                focusNode: passwordFocus,
                                nextFocus: confirmPassFocus,
                                maxLength: 30,
                                onFocusChange: (val) {
                                  setState(() {});
                                },
                                onChanged: (String value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      hasPasswordError = false;
                                    });
                                  }
                                },
                                title: 'Password',
                                hasError: hasPasswordError,
                                // errorText: Validations.ADDRESS_FIRST_NAME_VALIDATION,
                                textInputType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                textCapitalization: TextCapitalization.words,
                                obscureText: obscureText1,
                                suffixIcon: IconButton(
                                  splashRadius: 1,
                                  onPressed: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    setState(() {
                                      obscureText1 = !obscureText1;
                                    });
                                  },
                                  icon: Icon(
                                    !obscureText1
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              TextFieldWidget(
                                controller: _confirmPasswordController,
                                focusNode: confirmPassFocus,
                                nextFocus: firstNameFocus,
                                maxLength: 30,
                                onFocusChange: (val) {
                                  setState(() {});
                                },
                                onChanged: (String value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      hasConfiermPasswordError = false;
                                    });
                                  }
                                },
                                title: 'Confirm Password',
                                hasError: hasConfiermPasswordError,
                                // errorText: Validations.ADDRESS_FIRST_NAME_VALIDATION,
                                textInputType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                textCapitalization: TextCapitalization.words,
                                obscureText: obscureText2,
                                suffixIcon: IconButton(
                                  splashRadius: 1,
                                  onPressed: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    setState(() {
                                      obscureText2 = !obscureText2;
                                    });
                                  },
                                  icon: Icon(
                                    !obscureText2
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              TextFieldWidget(
                                controller: _firstNameController,
                                focusNode: firstNameFocus,
                                nextFocus: lastNameFocus,
                                maxLength: 30,
                                onFocusChange: (val) {
                                  setState(() {});
                                },
                                onChanged: (String value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      hasFirstNameError = false;
                                    });
                                  }
                                },
                                title: 'First Name',
                                hasError: hasFirstNameError,
                                // errorText: Validations.ADDRESS_FIRST_NAME_VALIDATION,
                                textInputType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                textCapitalization: TextCapitalization.words,
                              ),
                              TextFieldWidget(
                                controller: _lastNameController,
                                focusNode: lastNameFocus,
                                nextFocus: handicapFocus,
                                maxLength: 30,
                                onFocusChange: (val) {
                                  setState(() {});
                                },
                                onChanged: (String value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      hasLastNameError = false;
                                    });
                                  }
                                },
                                title: 'Last Name',
                                hasError: hasLastNameError,
                                // errorText: Validations.ADDRESS_FIRST_NAME_VALIDATION,
                                textInputType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                textCapitalization: TextCapitalization.words,
                              ),
                              TextFieldWidget(
                                controller: _handicapController,
                                focusNode: handicapFocus,
                                nextFocus: FocusNode(),
                                maxLength: 30,
                                onFocusChange: (val) {
                                  setState(() {});
                                },
                                onChanged: (String value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      hasHandicapError = false;
                                    });
                                  }
                                },
                                title: 'Handicap',
                                hasError: hasHandicapError,
                                // errorText: Validations.ADDRESS_FIRST_NAME_VALIDATION,
                                textInputType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                textCapitalization: TextCapitalization.words,
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "You are a: ",
                                    style:
                                        TextStyle(color: AppTheme.primaryColor),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                        value: Role.Player,
                                        groupValue: currentRole,
                                        onChanged: (role) {
                                          setState(() {
                                            currentRole = role as Role;
                                          });
                                        },
                                        fillColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return AppTheme.primaryColor;
                                          }
                                          return Colors.white;
                                        }),
                                        focusColor: Colors.white,
                                        activeColor: Colors.white,
                                      ),
                                      const Text(
                                        'Player',
                                        style: TextStyle(
                                            color: AppTheme.primaryColor),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: Role.Coach,
                                        groupValue: currentRole,
                                        onChanged: (role) {
                                          setState(() {
                                            currentRole = role as Role;
                                          });
                                        },
                                        fillColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return AppTheme.primaryColor;
                                          }
                                          return Colors.white;
                                        }),
                                      ),
                                      const Text(
                                        'Coach',
                                        style: TextStyle(
                                            color: AppTheme.primaryColor),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  isLoading
                      ? const CircularProgressIndicator(
                          color: AppTheme.primaryColor,
                        )
                      : _buildCreateAccount(),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Column(
                children: [
                  const Text(
                    "Have an account already?",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginView())),
                      child: const Text(
                        "Login here",
                        style: TextStyle(color: AppTheme.primaryColor),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class _SubmitButton extends StatelessWidget {
//   _SubmitButton({
//     Key? key,
//     required this.email,
//     required this.password,
//   }) : super(key: key);
//   final String email, password;

//   @override
//   Widget build(BuildContext context) {
    
//   }
// }
