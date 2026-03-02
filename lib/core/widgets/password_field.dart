import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 19.0),
        child: TextFormField(
          controller: controller,
          obscureText: true,
          maxLength: 6,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Password",
            counterText: "",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Ingresa tu contraseña";
            } else if (value.length != 6) {
              return "La contraseña debe tener 6 dígitos";
            }
            return null;
          },
        ),
      ),
    );
  }
}
