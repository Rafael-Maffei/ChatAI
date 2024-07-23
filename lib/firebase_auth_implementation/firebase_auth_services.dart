import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_ai/common/toast.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'Esse email já foi cadastrado.', color: Colors.red);
      } else if (e.code != 'channel-error') {
        showToast(message: 'Ocorreu um erro: ${e.code}', color: Colors.red);
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'channel-error' || e.code == 'invalid-credential') {
        showToast(message: 'Email  e/ou senha incorretos.', color: Colors.red);
      } else {
        showToast(message: 'Ocorreu um erro: ${e.code}', color: Colors.red);
      }
    }
    return null;
  }

  void signOut() {
    _auth.signOut();
    showToast(message: 'Usuário desconectado', color: Colors.black);
  }
}
