import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sign_in/authentication/screens/LoginScreen.dart';
import 'package:sign_in/qr/screens/QrScanner.dart';

import 'package:sign_in/user/screens/Home.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => MaterialPage(
        child: LoginScreen(),
      ),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: Home()),
  '/qr': (_) => const MaterialPage(child: QrScanner())
});
