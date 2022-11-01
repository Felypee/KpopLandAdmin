import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:sign_in/authentication/providers/loginProvider.dart';
import 'package:sign_in/authentication/widgets/AnimatedLogo.dart';
import 'package:sign_in/common/responseWidgets/Loader.dart';
import 'package:sign_in/common/widgets/CustomButton.dart';
import 'package:sign_in/common/widgets/CustomTextField.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final loading = ref.watch(logInProvider);
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                const AnimatedLogo(),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _emailController,
                        labelText: "Email",
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      CustomTextFormField(
                        controller: _passwordController,
                        labelText: "Contraseña",
                        isPassword: true,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                CustomButton(
                    child: const Text("Entrar"),
                    onPressed: () {
                      ref.read(logInProvider.notifier).logIn(
                          context,
                          _emailController.text.toLowerCase().trim(),
                          _passwordController.text.toLowerCase().trim());
                    }),
                SizedBox(
                  height: size.height * 0.04,
                ),
                GestureDetector(
                  onTap: () {
                    //TODO nos lleva a una pantalla para restaurar
                  },
                  child: const Text(
                    "Restaurar contraseña",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ]),
            ),
          ),
          !loading ? const SizedBox() : const Loader(),
        ],
      ),
    );
  }
}
