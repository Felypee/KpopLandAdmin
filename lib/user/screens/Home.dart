import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sign_in/authentication/providers/loginProvider.dart';
import 'package:sign_in/common/responseWidgets/Loader.dart';
import 'package:sign_in/user/widgets/Card.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final userName = ref.read(userProvider)?.name ?? "admin.";
    final loading = ref.watch(logInProvider);
    return Scaffold(
      backgroundColor: Colors.purple,
      bottomNavigationBar: loading
          ? null
          : CurvedNavigationBar(
              color: const Color.fromARGB(255, 122, 32, 138),
              buttonBackgroundColor: Colors.white,
              backgroundColor: Colors.purple,
              items: const [
                Icon(Icons.qr_code, size: 30),
              ],
              onTap: (index) {
                if (index == 0) {
                  Routemaster.of(context).push('/qr');
                }
              },
            ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.height * 0.01),
                child: Text(
                  "Hola, $userName",
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.height * 0.01),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref.read(logInProvider.notifier).logOut(context);
                      },
                      child: const Text(
                        "Cerrar sesión ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Icon(
                      Icons.logout,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                height: size.height * 0.2,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    HomeCard(title: "Clientes", data: "Pendientes: 5"),
                    HomeCard(title: "Clientes confirmados", data: "Total: 5"),
                    HomeCard(title: "Clientes en la fiesta", data: "Total: 5"),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
          !loading ? const SizedBox() : const Loader(),
        ],
      ),
    );
  }
}
