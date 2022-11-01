import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends ConsumerWidget {
  const CustomButton(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.buttonColor = Colors.blueGrey})
      : super(key: key);

  final Widget child;
  final VoidCallback onPressed;
  final Color buttonColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height * 0.08,
        width: size.width,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
                textStyle:
                    MaterialStateProperty.all(GoogleFonts.deliusSwashCaps()),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100))),
                backgroundColor: MaterialStateProperty.all(buttonColor)),
            child: child));
  }
}
