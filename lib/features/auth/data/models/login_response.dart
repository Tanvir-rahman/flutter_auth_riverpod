import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:resto_lite/features/auth/auth.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    @JsonKey(name: "token_type") String? tokenType,
    @JsonKey(name: "expires_in") int? expiresIn,
    @JsonKey(name: "access_token") String? accessToken,
    @JsonKey(name: "refresh_token") String? refreshToken,
  }) = _LoginResponse;

  const LoginResponse._();

  Login toEntity() => Login(
        tokenType: tokenType,
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresIn: expiresIn,
      );

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
