import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sign_in/qr/controllers/QrController.dart';

class QrScanner extends ConsumerWidget {
  const QrScanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Stack(
      children: [
        MobileScanner(
            allowDuplicates: false,
            onDetect: (barcode, args) {
              if (barcode.rawValue == null) {
                debugPrint('Failed to scan Barcode');
              } else {
                final String code = barcode.rawValue!;
                ref.read(qrControllerProvider).scanQR(context, code);
                debugPrint('Barcode found! $code');
              }
            }),
        _getOverlay()
      ],
    ));
  }
}

class InvertedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addPath(getPath(size), const Offset(0, 0));

//
    // ..addOval(Rect.fromCircle(
    //     center: Offset(size.width - 44, size.height - 44), radius: 40))
    // ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

Widget _getOverlay() {
  return ClipPath(
    clipper: InvertedClipper(),
    child: Container(
      color: Colors.black54,
    ),
  );
}

dynamic getPath(Size size) {
  Path path0 = Path();
  path0.moveTo(size.width * 0.15, size.height * 0.25);
  path0.lineTo(size.width * 0.15, size.height * 0.6960000);
  path0.lineTo(size.width * 0.9, size.height * 0.7000000);
  path0.lineTo(size.width * 0.9, size.height * 0.25);
  path0.close();
  return path0;
}
