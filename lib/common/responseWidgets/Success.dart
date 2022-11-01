import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sign_in/common/widgets/CustomButton.dart';

void showSuccessMessage(BuildContext context, String message) async {
  showGeneralDialog(
    barrierColor: Colors.white.withOpacity(0.3),
    context: context,
    pageBuilder: (_, __, ___) => Success(message: message),
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(anim1),
        child: child,
      );
    },
  );
}

class Success extends StatelessWidget {
  const Success({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Colors.white),
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset("assets/success.json", height: size.height * 0.25),
              const Text(
                "Exitoso!",
                style: TextStyle(fontSize: 40, color: Colors.red),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                message,
                style: const TextStyle(color: Colors.blueGrey),
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.09),
                child: CustomButton(
                    buttonColor: Colors.purple,
                    child: const Text("Ok"),
                    onPressed: () => Navigator.pop(context)),
              ),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
