import 'package:flutter/material.dart';

class RegistrerOrLoginButton extends StatelessWidget {
  const RegistrerOrLoginButton(
      {super.key, required this.isLogin, required this.onTap});

  final bool isLogin;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
        ),
        child:
              Center(
                child: Text( isLogin ? 'Login' : 'Criar conta',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
          ),
      );
  }
}
