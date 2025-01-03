import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:resto_lite/core/core.dart';
import 'package:resto_lite/features/features.dart';

part 'post_refresh_token.freezed.dart';
part 'post_refresh_token.g.dart';

class PostRefreshToken implements UseCase<Login, RefreshTokenParams> {
  final AuthRepository _repo;

  PostRefreshToken(this._repo);

  @override
  Future<Either<Failure, Login>> call(RefreshTokenParams params) =>
      _repo.refreshToken(params);
}

@freezed
class RefreshTokenParams with _$RefreshTokenParams {
  const factory RefreshTokenParams({
    @JsonKey(name: 'refresh_token') required String token,
  }) = _RefreshTokenParams;

  factory RefreshTokenParams.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenParamsFromJson(json);
}
