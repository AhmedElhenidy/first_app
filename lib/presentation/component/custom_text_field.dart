import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget{
  final String label;
  final bool secure;
  final EdgeInsetsGeometry padding;
  final TextEditingController? customController;
  CustomTextFiled({
    required this.label,
    this.secure=false,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    this.customController,
  });
  @override
  Widget build (BuildContext context){
    return Padding(
      padding: padding,
      child: TextField(
        controller: customController,
        obscureText: secure,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
              borderSide: const BorderSide(
                color: Colors.red,
              )
          ),
          labelText: label,
        ),
      ),
    );
  }
}