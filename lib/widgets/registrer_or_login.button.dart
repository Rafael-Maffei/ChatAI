import 'package:flutter/material.dart';

class RegistrerOrLoginButton extends StatelessWidget {
  const RegistrerOrLoginButton(
      {super.key, required this.isLogin, required this.onTap});

  final bool isLogin;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return isLogin
        ? GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Criar conta",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          );
  }
}
