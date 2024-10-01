import 'package:chat_ai/common/toast.dart';
import 'package:chat_ai/common/validators.dart';
import 'package:chat_ai/controllers/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:chat_ai/views/android/home.page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  final FirebaseAuthService auth = FirebaseAuthService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController loginEmailInput = TextEditingController();
  TextEditingController loginPasswordInput = TextEditingController();
  TextEditingController registerEmailInput = TextEditingController();
  TextEditingController registerPasswordInput = TextEditingController();
  Validators validators = Validators();

  void registerUser() async {
    isLoading.value = true;

    String email = registerEmailInput.text;
    String password = registerPasswordInput.text;

    if (validators.areCredentialsValid(email, password)) {
      User? user = await auth.signUpWithEmailAndPassword(email, password);
      if (user != null) {
        showToast(message: 'Usuário criado com sucesso', color: Colors.green);
        Get.to(const HomePage());
      }
    }
    isLoading.value = false;
    update();
  }

  void login() async {
    isLoading.value = true;

    String email = loginEmailInput.text;
    String password = loginPasswordInput.text;

    User? user = await auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      showToast(message: 'Usuário conectado', color: Colors.green);
      Get.to(const HomePage());
    }

    isLoading.value = false;
  }

  googleLogin() async {
    isLoading.value = true;

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
        Get.to(const HomePage());
      }
    } catch (e) {
      showToast(message: 'Ocorreu um erro $e', color: Colors.red);
    }
    isLoading.value = false;
  }
}
