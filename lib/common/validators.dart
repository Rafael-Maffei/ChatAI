import 'package:flutter/material.dart';
import 'package:chat_ai/common/toast.dart';

class Validators {
  bool isEmailValid(String email) {
    if (isFieldNotNull(email) &&
        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email)) {
      return true;
    }
    showToast(message: 'Insira um email válido.', color: Colors.red);
    return false;
  }

  bool isPasswordValid(String password) {
    if (isFieldNotNull(password) && password.length >= 6) {
      return true;
    }
    showToast(
        message: 'A senha deve ter ao menos 6 caracteres.', color: Colors.red);
    return false;
  }

  bool isFieldNotNull(String fieldValue) {
    return fieldValue.isNotEmpty ? true : false;
  }

  bool areCredentialsValid(String email, String password) {
    if (isEmailValid(email)) {
      if (isPasswordValid(password)) {
        return true;
      }
      return true;
    }
    return false;
  }
}
