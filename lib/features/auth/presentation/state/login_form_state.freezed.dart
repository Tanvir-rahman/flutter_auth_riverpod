// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginFormState {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  bool get isObscurePassword => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  ValidationFailure? get emailError => throw _privateConstructorUsedError;
  ValidationFailure? get passwordError => throw _privateConstructorUsedError;

  /// Create a copy of LoginFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginFormStateCopyWith<LoginFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginFormStateCopyWith<$Res> {
  factory $LoginFormStateCopyWith(
          LoginFormState value, $Res Function(LoginFormState) then) =
      _$LoginFormStateCopyWithImpl<$Res, LoginFormState>;
  @useResult
  $Res call(
      {String email,
      String password,
      bool isObscurePassword,
      bool isLoading,
      ValidationFailure? emailError,
      ValidationFailure? passwordError});
}

/// @nodoc
class _$LoginFormStateCopyWithImpl<$Res, $Val extends LoginFormState>
    implements $LoginFormStateCopyWith<$Res> {
  _$LoginFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? isObscurePassword = null,
    Object? isLoading = null,
    Object? emailError = freezed,
    Object? passwordError = freezed,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      isObscurePassword: null == isObscurePassword
          ? _value.isObscurePassword
          : isObscurePassword // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      emailError: freezed == emailError
          ? _value.emailError
          : emailError // ignore: cast_nullable_to_non_nullable
              as ValidationFailure?,
      passwordError: freezed == passwordError
          ? _value.passwordError
          : passwordError // ignore: cast_nullable_to_non_nullable
              as ValidationFailure?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginFormStateImplCopyWith<$Res>
    implements $LoginFormStateCopyWith<$Res> {
  factory _$$LoginFormStateImplCopyWith(_$LoginFormStateImpl value,
          $Res Function(_$LoginFormStateImpl) then) =
      __$$LoginFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String password,
      bool isObscurePassword,
      bool isLoading,
      ValidationFailure? emailError,
      ValidationFailure? passwordError});
}

/// @nodoc
class __$$LoginFormStateImplCopyWithImpl<$Res>
    extends _$LoginFormStateCopyWithImpl<$Res, _$LoginFormStateImpl>
    implements _$$LoginFormStateImplCopyWith<$Res> {
  __$$LoginFormStateImplCopyWithImpl(
      _$LoginFormStateImpl _value, $Res Function(_$LoginFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? isObscurePassword = null,
    Object? isLoading = null,
    Object? emailError = freezed,
    Object? passwordError = freezed,
  }) {
    return _then(_$LoginFormStateImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      isObscurePassword: null == isObscurePassword
          ? _value.isObscurePassword
          : isObscurePassword // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      emailError: freezed == emailError
          ? _value.emailError
          : emailError // ignore: cast_nullable_to_non_nullable
              as ValidationFailure?,
      passwordError: freezed == passwordError
          ? _value.passwordError
          : passwordError // ignore: cast_nullable_to_non_nullable
              as ValidationFailure?,
    ));
  }
}

/// @nodoc

class _$LoginFormStateImpl implements _LoginFormState {
  const _$LoginFormStateImpl(
      {this.email = '',
      this.password = '',
      this.isObscurePassword = false,
      this.isLoading = false,
      this.emailError,
      this.passwordError});

  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String password;
  @override
  @JsonKey()
  final bool isObscurePassword;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final ValidationFailure? emailError;
  @override
  final ValidationFailure? passwordError;

  @override
  String toString() {
    return 'LoginFormState(email: $email, password: $password, isObscurePassword: $isObscurePassword, isLoading: $isLoading, emailError: $emailError, passwordError: $passwordError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginFormStateImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.isObscurePassword, isObscurePassword) ||
                other.isObscurePassword == isObscurePassword) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other.emailError, emailError) &&
            const DeepCollectionEquality()
                .equals(other.passwordError, passwordError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      email,
      password,
      isObscurePassword,
      isLoading,
      const DeepCollectionEquality().hash(emailError),
      const DeepCollectionEquality().hash(passwordError));

  /// Create a copy of LoginFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginFormStateImplCopyWith<_$LoginFormStateImpl> get copyWith =>
      __$$LoginFormStateImplCopyWithImpl<_$LoginFormStateImpl>(
          this, _$identity);
}

abstract class _LoginFormState implements LoginFormState {
  const factory _LoginFormState(
      {final String email,
      final String password,
      final bool isObscurePassword,
      final bool isLoading,
      final ValidationFailure? emailError,
      final ValidationFailure? passwordError}) = _$LoginFormStateImpl;

  @override
  String get email;
  @override
  String get password;
  @override
  bool get isObscurePassword;
  @override
  bool get isLoading;
  @override
  ValidationFailure? get emailError;
  @override
  ValidationFailure? get passwordError;

  /// Create a copy of LoginFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginFormStateImplCopyWith<_$LoginFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
