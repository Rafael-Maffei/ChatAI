import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  final Widget? child;
  const SplashPage({super.key, this.child});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => widget.child!),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 20, 44),
      body: Center(
        child: Image.asset("assets/icon.png"),
      ),
    );
  }
}
