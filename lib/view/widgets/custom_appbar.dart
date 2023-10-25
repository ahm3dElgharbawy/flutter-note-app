import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Widget action;
  const CustomAppBar({super.key, required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(title,style: const TextStyle(fontWeight: FontWeight.bold),),
      foregroundColor: Colors.black,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      actions: [
        action
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

