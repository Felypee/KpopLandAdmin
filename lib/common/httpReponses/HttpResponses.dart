import 'package:freezed_annotation/freezed_annotation.dart';

part 'HttpResponses.freezed.dart';

@Freezed()
class CustomHttpResponse with _$CustomHttpResponse {
  factory CustomHttpResponse.success({String? message, dynamic data}) =
      _Success;
  factory CustomHttpResponse.failure({required String message}) = _Failure;
}
