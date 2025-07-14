import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'wellness_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Wellness());
}
