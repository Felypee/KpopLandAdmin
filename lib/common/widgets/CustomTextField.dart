import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField(
      {Key? key,
      this.controller,
      this.focusNode,
      this.labelText = "",
      this.isPassword = false})
      : super(key: key);

  TextEditingController? controller;
  //To automatically focus the next textfield
  FocusNode? focusNode;
  //The hint that is in the textfield
  String labelText;
  bool isPassword;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.deliusSwashCaps(),
      controller: widget.controller,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => widget.focusNode?.nextFocus(),
      obscureText: _passwordVisible,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        labelText: widget.labelText,
        hintStyle: const TextStyle(fontSize: 16, color: Colors.purple),
        labelStyle: const TextStyle(fontSize: 16, color: Colors.purple),
        suffixIcon: !widget.isPassword
            ? const SizedBox()
            : IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Icon(
                    _passwordVisible ? Icons.visibility_off : Icons.visibility,
                    color: Colors.purple,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
      ),
    );
  }
}
