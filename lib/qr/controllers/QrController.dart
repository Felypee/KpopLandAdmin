import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in/common/responseWidgets/Failure.dart';
import 'package:sign_in/common/responseWidgets/Success.dart';
import 'package:sign_in/qr/service/QrService.dart';

final qrControllerProvider = Provider(((ref) {
  final service = ref.watch(qrServiceProvider);
  return QrController(service: service);
}));

class QrController {
  const QrController({required this.service});
  final QrService service;
  void scanQR(BuildContext context, String code) async {
    final result = await service.scanQR(code);
    result.when(success: (message, data) {
      showSuccessMessage(context, message!);
    }, failure: (message) {
      showErrorMessage(context, message);
    });
  }
}
