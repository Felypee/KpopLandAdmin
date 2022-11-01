import 'package:flutter/cupertino.dart';
import 'package:gsheets/gsheets.dart';

Future<Worksheet> getWorkSheet({
  required Spreadsheet sheet,
  required String title,
}) async {
  final result = sheet.worksheetByTitle(title);
  if (result != null) {
    return result;
  } else {
    return await sheet.addWorksheet(title);
  }
}

//get only the id
String getIdfromCode(String code) {
  final list = code.split("/");
  final getLastValue = list[list.length - 1];
  final id = getLastValue.split("?")[1];
  final result = id.replaceAll("id=", "");
  return result;
}
