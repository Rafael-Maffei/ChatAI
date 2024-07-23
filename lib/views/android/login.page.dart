import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:chat_ai/common/toast.dart';
import 'package:chat_ai/common/validators.dart';
import 'package:chat_ai/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:chat_ai/widgets/formContainer.widget.dart';
import 'package:chat_ai/widgets/registry.button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  bool isLoading = false;
  final FirebaseAuthService auth = FirebaseAuthService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
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
                    'Login',
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
                    const RegistryButton(),
                  ],
                ),
                const SizedBox(height: 110),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        login();
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
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        googleLogin();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.google,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Entrar com Google",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }

  void login() async {
    setState(() {
      isLoading = true;
    });

    String email = emailInput.text;
    String password = passwordInput.text;

    User? user = await auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      showToast(message: 'Usuário conectado', color: Colors.green);
      Navigator.pushNamed(context, "/home");
    }

    setState(() {
      isLoading = false;
    });
  }

  googleLogin() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await firebaseAuth.signInWithCredential(credential);
        showToast(message: 'Conectado com Google', color: Colors.green);
        Navigator.pushNamed(context, "/home");
      }
    } catch (e) {
      showToast(message: 'Ocorreu um erro $e', color: Colors.red);
    }
  }
}
