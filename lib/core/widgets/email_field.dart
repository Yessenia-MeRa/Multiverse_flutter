import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({super.key, required this.controller});

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
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Email",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Ingresa tu email";
            }
            return null;
          },
        ),
      ),
    );
  }
}
