import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_ai/common/toast.dart';
import 'package:chat_ai/common/validators.dart';
import 'package:chat_ai/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:chat_ai/widgets/alreadyRegistered.button.dart';
import 'package:chat_ai/widgets/formContainer.widget.dart';

class RegistryPage extends StatefulWidget {
  const RegistryPage({super.key});

  @override
  State<RegistryPage> createState() => _RegistryPageState();
}

class _RegistryPageState extends State<RegistryPage> {
  bool isLoading = false;
  final FirebaseAuthService auth = FirebaseAuthService();
  TextEditingController emailInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();
  Validators validators = Validators();

  @override
  void dispose() {
    emailInput.dispose();
    passwordInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[850],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 150),
                child: const Text(
                  'Cadastro',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: [
                  FormContainerWidget(
                    icon: Icons.email_outlined,
                    controller: emailInput,
                    hintText: 'Email',
                    inputType: TextInputType.emailAddress,
                    isPasswordField: false,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FormContainerWidget(
                    icon: Icons.lock_outline,
                    controller: passwordInput,
                    hintText: 'Senha',
                    inputType: TextInputType.text,
                    isPasswordField: true,
                  ),
                  const SizedBox(height: 12),
                  const AlreadyRegisteredButton(),
                ],
              ),
              const SizedBox(height: 110),
              GestureDetector(
                onTap: () {
                  registerUser();
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Criar conta",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void registerUser() async {
    String email = emailInput.text;
    String password = passwordInput.text;

    if (validators.areCredentialsValid(email, password)) {
      User? user = await auth.signUpWithEmailAndPassword(email, password);
      if (user != null) {
        showToast(message: 'Usuário criado com sucesso', color: Colors.green);
        Navigator.pushNamed(context, "/home");
      }
    }
  }
}
