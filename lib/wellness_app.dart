import 'package:flutter/material.dart';
import 'package:wellness/login_screen.dart';

class Wellness extends StatelessWidget {
  const Wellness({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wellness',
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(secondary: Color(0xFF262626)),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: WidgetStateProperty.all(Colors.white),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.black,
          elevation: 3,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF1E1E1E),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          hintStyle: TextStyle(color: Colors.grey),
        ),
        timePickerTheme: TimePickerThemeData(
          backgroundColor: Color(0xFF1E1E1E),
          hourMinuteTextColor: Color(0xFF1E1E1E),
          hourMinuteColor: Colors.grey,
          dayPeriodTextColor: Colors.white70,
          dialBackgroundColor: Colors.black,
          dialHandColor: Colors.white,
          dialTextColor: Colors.white,
          entryModeIconColor: Colors.white,
          helpTextStyle: TextStyle(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        hoverColor: Colors.transparent,
      )
    );
  }
}
