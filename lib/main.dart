import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sign_in/authentication/providers/loginProvider.dart';
import 'package:sign_in/common/responseWidgets/Failure.dart';
import 'package:sign_in/common/responseWidgets/Loader.dart';
import 'package:sign_in/firebase_options.dart';
import 'package:sign_in/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authStateChangesProvider).when(
        data: (User? user) {
          return MaterialApp.router(
            routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
              if (user != null) {
                return loggedInRoute;
              }
              return loggedOutRoute;
            }),
            routeInformationParser: const RoutemasterParser(),
            title: 'Flutter Demo',
            theme: ThemeData(
              textTheme: TextTheme(
                  bodyText2: GoogleFonts.deliusSwashCaps(color: Colors.white)),
              primarySwatch: Colors.blue,
            ),
          );
        },
        error: (_, __) =>
            const Failure(message: "Error desconocido, intente de nuevo"),
        loading: () => const Loader());
  }
}
