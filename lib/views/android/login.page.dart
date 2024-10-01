import 'package:chat_ai/controllers/login_controller.dart';
import 'package:chat_ai/widgets/redirect.button.dart';
import 'package:chat_ai/widgets/registrer_or_login.button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:chat_ai/widgets/formfield.widget.dart';

LoginController controller = Get.put(LoginController());

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.grey[850],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    FormContainerWidget(
                      icon: Icons.email_outlined,
                      controller: controller.loginEmailInput,
                      hintText: 'Email',
                      inputType: TextInputType.emailAddress,
                      isPasswordField: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FormContainerWidget(
                      icon: Icons.lock_outline,
                      controller: controller.loginPasswordInput,
                      hintText: 'Senha',
                      inputType: TextInputType.text,
                      isPasswordField: true,
                    ),
                    const SizedBox(height: 12),
                    const RedirectButton(isLogin: true),
                  ],
                ),
                controller.isLoading.value
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Column(
                        children: [
                          RegistrerOrLoginButton(
                              isLogin: true,
                              isGoogle: false,
                              onTap: controller.login),
                          const SizedBox(
                            height: 10,
                          ),
                          RegistrerOrLoginButton(
                              isLogin: false,
                              isGoogle: true,
                              onTap: controller.googleLogin)
                        ],
                      ),
              ]),
        ),
      ),
    );
  }
}
