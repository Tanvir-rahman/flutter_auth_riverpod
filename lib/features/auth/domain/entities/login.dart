import 'package:freezed_annotation/freezed_annotation.dart';

part 'login.freezed.dart';

@freezed
class Login with _$Login {
  const factory Login({
    String? tokenType,
    String? accessToken,
    String? refreshToken,
    int? expiresIn,
  }) = _Login;
}
