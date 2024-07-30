import 'package:chat_ai/views/android/login.page.dart';
import 'package:chat_ai/views/android/registry.page.dart';
import 'package:flutter/material.dart';

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
          onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    isLogin ? const RegistryPage() : const LoginPage()),
            (route) => false,
          ),
          child: Text(
            isLogin ? 'Cadastre-se' : 'Entre',
            style: const TextStyle(
                color: Color.fromARGB(255, 174, 123, 196),
                fontWeight: FontWeight.bold,
                fontSize: 14,
                decoration: TextDecoration.underline,
                decorationColor: Color.fromARGB(255, 174, 123, 196)),
          ),
        ),
      ],
    );
  }
}
