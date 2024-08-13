
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.validateFunction,
    required this.inputFormatters,
    required this.label,
    this.obscureText=false,
    this.suffixIcon,

  });

  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String? Function(String?)? validateFunction;
  final  bool obscureText;
  final Widget? suffixIcon;
  final Widget? label;


  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      obscureText: obscureText,
      controller:controller ,
      cursorColor: Colors.black,
      decoration:  InputDecoration(
        suffixIcon: suffixIcon,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.black,fontSize: 20.0),
        enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)) ,
        focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
      ),
      inputFormatters:inputFormatters,
      validator:validateFunction,
    );
  }
}