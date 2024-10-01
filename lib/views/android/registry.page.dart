import 'package:chat_ai/controllers/login_controller.dart';
import 'package:chat_ai/widgets/registrer_or_login.button.dart';
import 'package:flutter/material.dart';
import 'package:chat_ai/widgets/redirect.button.dart';
import 'package:chat_ai/widgets/formfield.widget.dart';
import 'package:get/get.dart';

LoginController controller = Get.put(LoginController());

class RegistryPage extends StatelessWidget {
  const RegistryPage({super.key});
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
            children: [
              const Text(
                'Cadastro',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  FormContainerWidget(
                    icon: Icons.email_outlined,
                    controller: controller.registerEmailInput,
                    hintText: 'Email',
                    inputType: TextInputType.emailAddress,
                    isPasswordField: false,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FormContainerWidget(
                    icon: Icons.lock_outline,
                    controller: controller.registerPasswordInput,
                    hintText: 'Senha',
                    inputType: TextInputType.text,
                    isPasswordField: true,
                  ),
                  const SizedBox(height: 12),
                  const RedirectButton(isLogin: false),
                ],
              ),
              Obx(
                () => controller.isLoading.value
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : RegistrerOrLoginButton(
                        isLogin: false,
                        isGoogle: false,
                        onTap: controller.registerUser),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
