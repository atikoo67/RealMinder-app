import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;

  const MyTextField({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,

      style: TextStyle(fontSize: 15),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.4,
            color: const Color.fromARGB(186, 154, 154, 154),
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.4,
            color: const Color.fromARGB(186, 154, 154, 154),
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.4,
            color: const Color.fromARGB(186, 154, 154, 154),
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        // filled: true,
        // fillColor: theme.colorScheme.secondary,
        hintText: label,
        hintStyle: TextStyle(color: const Color.fromARGB(185, 96, 96, 96)),
      ),
      onChanged: (value) {},
    );
  }
}
