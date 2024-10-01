import 'package:chat_ai/views/android/login.page.dart';
import 'package:chat_ai/views/android/registry.page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RedirectButton extends StatelessWidget {
  final bool isLogin;

  const RedirectButton({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin ? 'Não tem uma conta?' : 'Já tem uma conta?',
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () => Get.to(isLogin ? const RegistryPage() : const LoginPage()),
          child: Text(
            isLogin ? 'Cadastre-se' : 'Entre',
            style: const TextStyle(
                color: Color.fromRGBO(61, 114, 180, 1.0),
                fontWeight: FontWeight.bold,
                fontSize: 14,
                decoration: TextDecoration.underline,
                decorationColor: Color.fromRGBO(61, 114, 180, 1.0)),
          ),
        ),
      ],
    );
  }
}
