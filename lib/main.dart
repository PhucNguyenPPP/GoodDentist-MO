import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/app.dart';
import 'package:good_dentist_mobile/src/api/firebase/firebase_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}