import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gsheets/gsheets.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in/qr/utils.dart' as utils;
import 'package:audioplayers/audioplayers.dart';

import 'package:sign_in/common/httpReponses/HttpResponses.dart';
import 'package:vibration/vibration.dart';

final qrServiceProvider = Provider((ref) => QrService());

class QrService {
  static const _credentials = {
    "type": "service_account",
    "project_id": "kpoplandapp",
    "private_key_id": "7a733efe3f7b095c4d13aa1bad234c9e54129974",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCvhLgUXjOk2sI6\n8k2O37dgMPHQqMkGNYF6NXaE3+Dcv3CIvIK1jnMI7enmTZNco+yqqO6gqrXgdrSR\nNpvjlK/yMIMPgzV4IfmIwlAKF5Lt5vp09rbiicHKCexCxwLcPr/CiCMaiZiIp64Y\nLD+xqcZmhGo9A0Gt6tkZHdilKcNy8/BR4eLOfDpK8/h6J2GdbDMrkTGj29NCfMEI\nqM69j95mLjTDGw4mjQ2GkOZCfuwyJhJElLeJXPLnrHSy4L/Rrx26R4YlRGZDQ2zd\noYy4dNg1mXPsGp1gZMN9WDC6lOVlmPhtvoPUcN3aX1y7spqFP2lMRbLnwNYw2sSK\nMQJ+40ShAgMBAAECggEACi2KYHanTKukJbeVSHAFTzOnYhqCMF+mlsfw4SWmVsas\nfOa0NwOqp12RzwQNQ+BRl1fdIT36S/42MabWsAIYQyq4VDb0lncfOY9NsDghEgtE\nghx9tcdCkI0La+05vOclRt+OwY7cZILstS7OXBFklYn01dLm2nH1jYpN3M3+LR/g\nHStC/6/aCQR2uj7VjlwKhud5AuRzsEjXtSnknv9hB3n4c8nrB5c7JN0Ux882TPvz\naujEfrnAFIEy0Zs7Hrr7RRhnyhMmon06OqcrDM46oendziVZIlqNVPN8Z0+67Gey\nflLdzWY+f+PJaeDFWvdMC4O9Y3jmeftqoUdI+vkovQKBgQDqs1w+2AtMU79C1Q2e\neHbrdwad1tcBv9ICh3tVZlyRoHTbcXfp2QpF1eGBwp8n8Uvrq8/fFbUJt9gNAJ3d\nsnr1CCdTuJZ6aNy/3yTMcQ09ZZ3CKYR3gpGLzVgy7C5fbPL/QCcePRwPJ/LuX0iU\nAeIbk5kO7rdkrycX+CEDqc/pUwKBgQC/cmtQGYwM6pNTfrBJNIYG/voXJ9ZSU0Z8\nn6cCrX3kDkvBQMWNx9iYZTOU8MYvE7mK7nEKsYXn6YeFzE4EO305jb/amKvOxtpP\nrr+Mv5VE+6U4SD7wg1VcUj5eIDbnl8i9PxqWi7gmxpFwBdGGANEfGMUwf8mQkZWL\nViNVYDE3uwKBgHUiNvOWV20sjtQICNgCPzedG8xCoOPanDFu9HrWr3RupGOw6avo\nClx4NifQviXtI3rnMMOhzcyf2FAE8sTmgr8v5pC+GzvUgfewomj2MyllQarZlacf\nnwwq283uWeZ+NXh2yA8raImX4oJdQ5e6qOIic80kDptNXzFzQObXJVDJAoGAM95w\nLLd/NlCnsct1P6A3X9XdNEDa1Fszkbg/q34NyagF5koCPDOU/1UL8KJ7T23sqzOG\n9Pq76OVgjmOYD5V+jAVXoYYTpmZB56zUwPF3I8V6MhGA2/D5Q5YUx7O6rGx3Oq7K\nKVeZgQfzh4JMDh5SijZP1qAIoF6RQbsIv6zcKNkCgYEAlTIwCE3aQhRE/yQkGC/l\nKv1YJ7Yi8mdnSxhydMtaiT6JAEO6Ece7OagCoCWhRASZzEDHwJvpXdyYOFFoqoNU\na9sGur/+/3QbNdyelWqcslq4bCvK/Q3lCnPUxZ2z+RPtqj7/cGKEDqjrUlng3u7b\nj8OFdkaNfBB4mYgWEfSb+cc=\n-----END PRIVATE KEY-----\n",
    "client_email": "qrsheets@kpoplandapp.iam.gserviceaccount.com",
    "client_id": "104380132665922546568",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/qrsheets%40kpoplandapp.iam.gserviceaccount.com"
  };

  static final _gsSheets = GSheets(_credentials);
  static const _spreadSheetsID = "1xDH6r9Q1agONvavb5DVcl1c5kP6A9QzSj4ssXV2iJr0";
  static Worksheet? _userSheet;

  Future<CustomHttpResponse> scanQR(String code) async {
    try {
      final hasVibrator = await Vibration.hasVibrator();
      String id = utils.getIdfromCode(code);
      final spreadSheet = await _gsSheets.spreadsheet(_spreadSheetsID);
      _userSheet =
          await utils.getWorkSheet(sheet: spreadSheet, title: "AssistanceList");
      final result = await _userSheet!.values.rowByKey(id);

      if (result == null) {
        return CustomHttpResponse.failure(message: "Qr no existe");
      }

      final verified = result[result.length - 1];
      if (verified == "true") {
        if (hasVibrator != null && hasVibrator) {
          Vibration.vibrate();
          await Future.delayed(const Duration(milliseconds: 500));
          Vibration.vibrate();
        }
        return CustomHttpResponse.failure(message: "Qr ya escaneado");
      }

      final scanned = await _userSheet!.values
          .insertValueByKeys("true", rowKey: id, columnKey: "Verified");
      if (!scanned) {
        return CustomHttpResponse.failure(
            message: "Ocurrió un error, intente de nuevo");
      }
      final player = AudioPlayer();
      if (hasVibrator != null && hasVibrator) {
        Vibration.vibrate();
      }
      await player.play(AssetSource("success.wav"));
      return CustomHttpResponse.success(message: "Escaneado con Exito");
    } catch (error) {
      return CustomHttpResponse.failure(message: "Error: error");
    }
  }
}
