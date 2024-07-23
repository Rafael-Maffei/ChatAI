import 'package:flutter/material.dart';
import 'package:chat_ai/views/android/login.page.dart';

class AlreadyRegisteredButton extends StatelessWidget {
  const AlreadyRegisteredButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Já tem uma conta?", style: TextStyle(color: Colors.white, fontSize: 14),),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
            );
          },
          child: const Text(
            "Entre",
            style: TextStyle(
              color: Color.fromARGB(255, 174, 123, 196),
              fontWeight: FontWeight.bold,
              fontSize: 14,
              decoration: TextDecoration.underline,
              decorationColor: Color.fromARGB(255, 174, 123, 196)
            ),
          ),
        ),
      ],
    );
  }
}
