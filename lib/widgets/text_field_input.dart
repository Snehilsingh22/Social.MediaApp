import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextField(
      style: TextStyle(color: Colors.black),
      controller: textEditingController,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.grey),
        hintText: hintText,
        border: inputBorder,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.deepPurple),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      // decoration: InputDecoration(
      //   hintText: hintText,
      //   hintStyle: TextStyle(
      //     // fontWeight: FontWeight.w500,
      //     fontSize: 15,
      //     color: Colors.grey.shade700,
      //   ),
      //   enabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(10),
      //     borderSide: const BorderSide(color: Colors.black12),
      //   ),
      //   focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(10),
      //     borderSide:
      //         const BorderSide(color: Color.fromARGB(255, 109, 41, 197)),
      //   ),
      // ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
