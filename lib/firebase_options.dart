// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC0zFPE9J52MBD7nTY2CMypwW6Cl-TH-vw',
    appId: '1:1091963030528:web:2f8798b8a47e1054d11ce5',
    messagingSenderId: '1091963030528',
    projectId: 'kpoplandapp',
    authDomain: 'kpoplandapp.firebaseapp.com',
    storageBucket: 'kpoplandapp.appspot.com',
    measurementId: 'G-NZFC3D3XQ8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCrLZ3Z02gTz3TxFiP3HFtUFLLdzgNR0d0',
    appId: '1:1091963030528:android:53e77d188d11077fd11ce5',
    messagingSenderId: '1091963030528',
    projectId: 'kpoplandapp',
    storageBucket: 'kpoplandapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBDGUQmHSt8DjQ1NTprYKtI2KzxgL-s7Uo',
    appId: '1:1091963030528:ios:59653a136b3737d4d11ce5',
    messagingSenderId: '1091963030528',
    projectId: 'kpoplandapp',
    storageBucket: 'kpoplandapp.appspot.com',
    iosClientId: '1091963030528-il9mffp1fh82k7u10tikebuci7ebukn1.apps.googleusercontent.com',
    iosBundleId: 'com.example.signIn',
  );
}
