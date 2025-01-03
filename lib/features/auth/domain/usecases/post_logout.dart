import 'package:dartz/dartz.dart';
import 'package:resto_lite/core/core.dart';
import 'package:resto_lite/features/features.dart';

class PostLogout implements UseCase<String, NoParams> {
  final AuthRepository _repo;

// coverage:ignore-start
  PostLogout(this._repo);

  @override
  Future<Either<Failure, String>> call(NoParams _) => _repo.logout();
// coverage:ignore-end
}
