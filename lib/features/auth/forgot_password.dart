import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellness/popup.dart';
import 'package:wellness/service/auth_service.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              spacing: 30.h,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 32.sp
                  ),
                ),

                Form(
                  key: _formKey,
                  child: Column(
                    spacing: 40.sp,
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
                            fontSize: 18.sp
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

                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () async{
                            if(_formKey.currentState != null && _formKey.currentState!.validate()){
                              String? result = await AuthService().sendPasswordResetEmail(_emailController.text);
                              result = result??"";
                              log(result);
                              if(result.startsWith("Success")) {
                                String message = result.split("Success: ")[1];
                                Popup.show(context, message, type: PopupType.success);
                              }
                              else {
                                String message = result.split("Error: ")[1];
                                Popup.show(context, message, type: PopupType.error);
                              }
                            }
                          },

                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[900],
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r)
                            )
                          ),

                          child: Text(
                            'Send Reset Email',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      )
    );
  }
}
