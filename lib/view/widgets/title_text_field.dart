import 'package:flutter/material.dart';

class TitleTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  final TextInputType? keyboardType;

  const TitleTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontSize: 25),
      keyboardType: keyboardType,
      maxLines: null,
      decoration: InputDecoration(
        isCollapsed: true,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 25), 
        border: InputBorder.none,
      ),
      cursorHeight: 30,
      cursorColor: const Color.fromARGB(255, 123, 123, 123),
      controller: controller,
    );

}
}