import 'package:flutter/material.dart';

class ContentTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  final TextStyle? style;
  final TextInputType? keyboardType;

  const ContentTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.keyboardType,
      this.style});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: style,
      keyboardType: keyboardType,
      maxLines: null,
      decoration: InputDecoration(
        isCollapsed: true,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 16),
        border: InputBorder.none,
        
      ),
      minLines: 10,
      cursorHeight: 25,
      cursorColor: const Color(0xffabaaac),
      controller: controller,
    );
  }
}
