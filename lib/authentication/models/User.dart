import 'package:freezed_annotation/freezed_annotation.dart';

part 'User.freezed.dart';
part 'User.g.dart';

@Freezed()
class UserModel with _$UserModel {
  const factory UserModel({required String name}) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
}
