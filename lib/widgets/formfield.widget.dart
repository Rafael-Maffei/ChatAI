import 'package:flutter/material.dart';

class FormContainerWidget extends StatefulWidget {
  final TextEditingController? controller;
  final bool? isPasswordField;
  final IconData icon;
  final String? hintText;
  final TextInputType? inputType;

  const FormContainerWidget(
      {super.key,
      this.controller,
      this.isPasswordField,
      required this.icon,
      this.hintText,
      this.inputType});

  @override
  State<FormContainerWidget> createState() => _FormContainerWidget();
}

class _FormContainerWidget extends State<FormContainerWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.inputType,
      obscureText: widget.isPasswordField == true ? _obscureText : false,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      cursorColor: const Color.fromRGBO(61, 114, 180, 1.0),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
        filled: true,
        fillColor: Colors.grey[900],
        prefixIcon: Icon(widget.icon, color: Colors.grey),
        suffixIcon: GestureDetector(
          onTap: () => setState(() {
              _obscureText = !_obscureText;
            }),
          child: widget.isPasswordField == true
              ? Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: _obscureText == false
                      ? const Color.fromRGBO(61, 114, 180, 1.0)
                      : Colors.grey,
                )
              : const Text(''),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(61, 114, 180, 1.0)),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
