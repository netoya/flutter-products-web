import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    this.hintText = "",
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.blueGrey),
          contentPadding: const EdgeInsets.only(top: 0, left: 0, right: 0),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          )),
      controller: controller,
    );
  }
}

class CustomNumberField extends StatelessWidget {
  const CustomNumberField({
    Key? key,
    required this.controller,
    this.hintText = "",
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (v) => num.tryParse(v!) == null ? "invalid number" : null,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]'))],
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.blueGrey),
          contentPadding: const EdgeInsets.only(top: 0, left: 0, right: 0),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          )),
      controller: controller,
    );
  }
}

class CustomPasswordField extends StatelessWidget {
  const CustomPasswordField({
    Key? key,
    required this.controller,
    this.hintText = "",
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.blueGrey),
          contentPadding: const EdgeInsets.only(top: 0, left: 0, right: 0),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          )),
      autocorrect: false,
      obscureText: true,
      enableSuggestions: false,
      controller: controller,
    );
  }
}
