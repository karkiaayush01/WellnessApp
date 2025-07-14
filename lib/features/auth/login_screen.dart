import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellness/core/route_config/route_name.dart';
import 'package:wellness/features/topic_selector/topic_selector.dart';
import 'package:wellness/features/auth/register_screen.dart';
import 'package:wellness/service/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
  bool _hidePass = true;
  bool _rememberMeCheck = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              spacing: 20.h,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 30.h),
                  child: Text(
                    'Welcome back!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 32.sp
                    ),
        
                  ),
                ),
        
                Form(
                  key: _loginFormKey,
                  child: Column(
                    spacing: 20.h,
                    children: [
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
                          fontSize: 20.sp
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter your email",
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h), // Adjust to control icon size and position
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

                          return null;
                        },
                        style: TextStyle(
                          fontSize: 20.sp
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                            child: SvgPicture.asset(
                              'assets/icons/lock.svg',
                              height: 24.h,
                              width: 24.w,
                              fit: BoxFit.scaleDown,
                              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                            ),
                          ),
        
                          suffixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
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
        
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                                fontSize: 18.sp
                            ),
                          )
                        ],
                      ),
        
                      Column(
                        spacing: 16.h,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                if (
                                  _loginFormKey.currentState != null &&
                                  _loginFormKey.currentState!.validate()
                                ) {
                                  _loginFormKey.currentState!.save();

                                  Navigator.of(context).pushNamed( RouteName.topicSelect );
                                }
                              },
        
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.grey[900],      // Button color
                                padding: EdgeInsets.symmetric(vertical: 16.h), // Button height
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),  // Rounded corners
                                ),
                              ),
        
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
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
                                Navigator.of(context).pushNamed(
                                    (RouteName.adminDashboard)
                                );
                                // UserCredential? user = await AuthService().signInWithGoogle();
                                //
                                // if (user != null) {
                                //   //register is successful
                                //   Navigator.of(context).pushNamed(
                                //       (RouteName.adminDashboard)
                                //   );
                                // }
                              },
        
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.grey[900],      // Button color
                                padding: EdgeInsets.symmetric(vertical: 16.h), // Button height
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),  // Rounded corners
                                ),
                              ),
        
                              child: Row(
                                  spacing: 16.w,
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
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 16.sp
                        ),
                      ),
        
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (ctx) {
                                    return RegisterScreen();
                                  }
                              )
                            );
                          },
        
                          child: Text(
                            "Create an account",
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
    );
  }
}


