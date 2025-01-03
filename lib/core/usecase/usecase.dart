import 'package:dartz/dartz.dart';
import 'package:resto_lite/core/core.dart';

abstract interface class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Class to handle when useCase don't need params
class NoParams {}
