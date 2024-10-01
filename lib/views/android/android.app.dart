import 'package:flutter/material.dart';
import 'package:chat_ai/views/android/home.page.dart';
import 'package:chat_ai/views/android/login.page.dart';
import 'package:chat_ai/views/android/registry.page.dart';
import 'package:chat_ai/views/android/splash.page.dart';
import 'package:get/get.dart';

class AndroidApp extends StatelessWidget {
  const AndroidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashPage(
          child: LoginPage(),
        ),
        routes: {
          '/home': (context) => const HomePage(),
          '/login': (context) => const LoginPage(),
          '/registry': (context) => const RegistryPage(),
        });
  }
}
