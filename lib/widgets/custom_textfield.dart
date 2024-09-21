import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final String? prefixicon;
  final String? suffixIcon;
  final String? Function(String?)? validater;

  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.prefixicon,
    this.validater,
    this.suffixIcon,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        validator: widget.validater ?? null,
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          prefixIconConstraints:
              const BoxConstraints(minWidth: 40, minHeight: 20),
          filled: true,
          fillColor: const Color(0xFFeeedec),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
              color: Color(0xFFa7a6a5),
              fontSize: 14,
              fontWeight: FontWeight.w400),
          prefixIcon: (widget.prefixicon == null)
              ? null
              : Image.asset(
                  widget.prefixicon!,
                  scale: 3.3,
                ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFeeedec), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Color(0xFFeeedec), width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            //borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //labelText: widget.labelText,
          // labelStyle: TextStyle(
          //   color: Color(0xFFF454545),
          // )
        ),

        // autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
