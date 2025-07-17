import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellness/core/route_config/route_name.dart';
import 'package:wellness/features/auth/login_screen.dart';
import 'package:wellness/service/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
  final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');
  bool _hidePass = true;
  bool _hideConfirmPass = true;
  bool _rememberMeCheck = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      'Start your wellness journey today.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 32.sp
                      ),

                    ),
                  ),

                  Form(
                    key: _registerFormKey,
                    child: Column(
                      spacing: 20,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          validator: (String? value) {
                            if((value??'').isEmpty){
                              return "Name is required";
                            }
                            return null;
                          },
                          style: TextStyle(
                              fontSize: 18.sp
                          ),
                          decoration: InputDecoration(
                            hintText: "Enter your name",
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(12), // Adjust to control icon size and position
                              child: SvgPicture.asset(
                                'assets/icons/user.svg',
                                fit: BoxFit.scaleDown,
                                height: 24.h,
                                width: 24.w,
                                colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),

                        TextFormField(
                          controller: _emailController,
                          validator: (String? value) {
                            if((value??'').isEmpty) {
                              return "Email is required";
                            }
                            else if(!emailRegex.hasMatch(value??'')){
                              return("Invalid Email");
                            }
                            return null;
                          },
                          style: TextStyle(
                              fontSize: 18.sp
                          ),
                          decoration: InputDecoration(
                            hintText: "Enter your email",
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(12), // Adjust to control icon size and position
                              child: SvgPicture.asset(
                                'assets/icons/mail.svg',
                                fit: BoxFit.scaleDown,
                                height: 24.h,
                                width: 24.w,
                                colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),

                        TextFormField(
                            obscureText: _hidePass,
                            controller: _passwordController,
                            validator: (String? value) {
                              if((value??'').isEmpty){
                                return "Password is required.";
                              }
                              else if((value??'').length < 8) {
                                return "Password must be at least 8 characters long.";
                              }
                              else if(!passwordRegex.hasMatch(value??'')){
                                return "Invalid Password. Must be at least 1 Uppercase, 1 Lowercase, 1 Symbol, 1 Number.";
                              }
                              return null;
                            },
                            style: TextStyle(
                                fontSize: 18.sp
                            ),
                            decoration: InputDecoration(
                                hintText: "Enter your password",
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: SvgPicture.asset(
                                    'assets/icons/lock.svg',
                                    height: 24.h,
                                    width: 24.w,
                                    fit: BoxFit.scaleDown,
                                    colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                                  ),
                                ),

                                suffixIcon: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: IconButton(
                                      icon: SvgPicture.asset(
                                        _hidePass ? 'assets/icons/eye_off.svg' : 'assets/icons/eye.svg',
                                        height: 24.h,
                                        width: 24.w,
                                        fit: BoxFit.scaleDown,
                                        colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _hidePass = !_hidePass;
                                        });
                                      },
                                    )
                                )
                            )
                        ),

                        TextFormField(
                          obscureText: _hideConfirmPass,
                          controller: _confirmPasswordController,
                          validator: (String? value) {
                            if((value??'').isEmpty){
                              return "Password is required.";
                            }
                            else if((value??'') != _passwordController.text) {
                              return "Passwords doesn't match.";
                            }
                            return null;
                          },
                          style: TextStyle(
                              fontSize: 18.sp
                          ),
                          decoration: InputDecoration(
                              hintText: "Re-enter your password",
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(12),
                                child: SvgPicture.asset(
                                  'assets/icons/lock.svg',
                                  height: 24.h,
                                  width: 24.w,
                                  fit: BoxFit.scaleDown,
                                  colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                                ),
                              ),

                              suffixIcon: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: IconButton(
                                    icon: SvgPicture.asset(
                                      _hideConfirmPass ? 'assets/icons/eye_off.svg' : 'assets/icons/eye.svg',
                                      height: 24.h,
                                      width: 24.w,
                                      fit: BoxFit.scaleDown,
                                      colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _hideConfirmPass = !_hideConfirmPass;
                                      });
                                    },
                                  )
                              )
                          )
                        ),

                        Row(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMeCheck,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      _rememberMeCheck = newValue!;
                                    });
                                  },
                                  activeColor: Colors.white,
                                ),

                                Text(
                                  'Remember Me',
                                  style: TextStyle(
                                      fontSize: 18.sp
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),

                        Column(
                          spacing: 16,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () async {
                                  String email = _emailController.text;
                                  String password = _passwordController.text;
                                  String name = _nameController.text;
                                  if(
                                    _registerFormKey.currentState != null &&
                                    _registerFormKey.currentState!.validate()
                                  ) {
                                    _registerFormKey.currentState!.save();

                                    UserCredential? user = await AuthService().signUpWithEmailAndPass(email, password,name);
                                    if(user != null) {
                                      Navigator.pushNamed(context, RouteName.dashboardScreen);
                                    }
                                  }
                                },

                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,      // Button color
                                  padding: EdgeInsets.symmetric(vertical: 16), // Button height
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),  // Rounded corners
                                  ),
                                ),

                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                  ),
                                ),

                              ),
                            ),

                            Text(
                                'Or',
                                style: TextStyle(
                                    fontSize: 18.sp
                                )
                            ),

                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () async{
                                  UserCredential? user = await AuthService().signInWithGoogle();

                                  if (user != null) {
                                    log("user logged in");
                                    //register is successful
                                    Navigator.of(context).pushNamed(
                                        (RouteName.dashboardScreen)
                                    );
                                  }
                                },

                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.grey[900],      // Button color
                                  padding: EdgeInsets.symmetric(vertical: 16), // Button height
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),  // Rounded corners
                                  ),
                                ),

                                child: Row(
                                    spacing: 16,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/google.svg',
                                        height: 24.h,
                                        width: 24.w,
                                        fit: BoxFit.scaleDown,
                                        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                      ),
                                      Text(
                                        'Google',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ]
                                ),

                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                              fontSize: 16.sp
                          ),
                        ),

                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (ctx) {
                                        return LoginScreen();
                                      }
                                  )
                              );
                            },

                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white
                              ),
                            )
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ),
        ),
      )
    );
  }
}
