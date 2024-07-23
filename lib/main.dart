import 'package:chat_ai/consts/keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:chat_ai/views/android/android.app.dart';

void main() async {  
  Gemini.init(apiKey: GEMINI_API_KEY);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: FIREBASE_API_KEY,
          appId: '1:454714648574:android:fd95b4651ac126421882af',
          messagingSenderId: 'sendId',
          projectId: 'myapp'));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const AndroidApp());
}
