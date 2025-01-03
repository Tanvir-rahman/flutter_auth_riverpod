import 'package:dartz/dartz.dart';
import 'package:resto_lite/core/error/failure.dart';
import 'package:resto_lite/utils/validators.dart';

class AuthValidators {
  final _validators = const Validators();

  Either<ValidationFailure, String> email(String? value) {
    final result = _validators.email(value);

    return result.fold(
      (failure) => Left(ValidationFailure(failure.message)),
      Right.new,
    );
  }

  Either<ValidationFailure, String> password(String? value) {
    final result = _validators.minLength(
      value,
      length: 6,
      fieldName: 'Password',
    );

    return result.fold(
      (failure) => Left(ValidationFailure(failure.message)),
      Right.new,
    );
  }

  Either<ValidationFailure, String> confirmPassword(
    String? value,
    String password,
  ) {
    final result = _validators.required(value, fieldName: 'Confirm password');

    return result.fold(
      (failure) => Left(ValidationFailure(failure.message)),
      (confirmedPassword) {
        if (confirmedPassword != password) {
          return const Left(ValidationFailure('Passwords do not match'));
        }
        return Right(confirmedPassword);
      },
    );
  }

  Either<ValidationFailure, String> phoneNumber(String? value) {
    final result = _validators.required(value, fieldName: 'Phone number');

    return result.fold(
      (failure) => Left(ValidationFailure(failure.message)),
      Right.new,
    );
  }
}
