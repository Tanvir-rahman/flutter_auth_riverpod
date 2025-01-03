import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:resto_lite/core/error/failure.dart';

part 'login_form_state.freezed.dart';

@freezed
class LoginFormState with _$LoginFormState {
  const factory LoginFormState({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool isObscurePassword,
    @Default(false) bool isLoading,
    ValidationFailure? emailError,
    ValidationFailure? passwordError,
  }) = _LoginFormState;
}
