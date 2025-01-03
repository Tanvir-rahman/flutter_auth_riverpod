import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:resto_lite/core/core.dart';
import 'package:resto_lite/features/features.dart';

part 'post_update_password.freezed.dart';
part 'post_update_password.g.dart';

class PostUpdatePassword implements UseCase<void, UpdatePasswordParams> {
  final AuthRepository _repo;

  PostUpdatePassword(this._repo);

  @override
  Future<Either<Failure, void>> call(UpdatePasswordParams params) =>
      _repo.updatePassword(params);
}

@freezed
class UpdatePasswordParams with _$UpdatePasswordParams {
  const factory UpdatePasswordParams({
    @JsonKey(name: 'old_password') required String oldPassword,
    @JsonKey(name: 'password') required String newPassword,
  }) = _UpdatePasswordParams;

  factory UpdatePasswordParams.fromJson(Map<String, dynamic> json) =>
      _$UpdatePasswordParamsFromJson(json);
}
