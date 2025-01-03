import 'package:dartz/dartz.dart';
import 'package:resto_lite/core/error/failure.dart';

class Validators {
  const Validators();

  Either<Failure, String> email(String? value) {
    final requiredCheck = required(value, fieldName: 'email');
    if (requiredCheck.isLeft()) return requiredCheck;

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return requiredCheck.fold(
      (failure) => Left(failure),
      (value) {
        if (!emailRegex.hasMatch(value)) {
          return const Left(Failure.validation('Please enter a valid email'));
        }
        return Right(value.trim());
      },
    );
  }

  Either<Failure, String> required(
    String? value, {
    String? fieldName,
  }) {
    if (value == null || value.isEmpty) {
      return Left(
        Failure.validation(
          'Please enter ${fieldName?.toLowerCase() ?? 'this field'}',
        ),
      );
    }
    return Right(value.trim());
  }

  Either<Failure, String> minLength(
    String? value, {
    required int length,
    String? fieldName,
  }) {
    final requiredCheck = required(value, fieldName: fieldName);
    if (requiredCheck.isLeft()) return requiredCheck;

    return requiredCheck.fold(
      (failure) => Left(failure),
      (value) {
        if (value.length < length) {
          return Left(
            Failure.validation(
              '${fieldName ?? 'Field'} must be at least $length characters',
            ),
          );
        }
        return Right(value);
      },
    );
  }
}
