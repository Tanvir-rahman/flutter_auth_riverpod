import 'package:resto_lite/features/auth/auth.dart';
import 'package:resto_lite/features/auth/presentation/state/login_form_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_form_notifier.g.dart';

@riverpod
class LoginFormNotifier extends _$LoginFormNotifier {
  late final AuthValidators _validators;

  @override
  LoginFormState build() {
    _validators = AuthValidators();
    return const LoginFormState();
  }

  void updateEmail(String email) {
    final validation = _validators.email(email);
    state = validation.fold(
      (failure) => state.copyWith(email: email, emailError: failure),
      (validEmail) => state.copyWith(email: validEmail, emailError: null),
    );
  }

  void updatePassword(String password) {
    final validation = _validators.password(password);
    state = validation.fold(
      (failure) => state.copyWith(password: password, passwordError: failure),
      (validPassword) =>
          state.copyWith(password: validPassword, passwordError: null),
    );
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isObscurePassword: !state.isObscurePassword);
  }

  bool get isValid =>
      state.emailError == null &&
      state.passwordError == null &&
      state.email.isNotEmpty &&
      state.password.isNotEmpty;

  Future<void> login(PostLogin postLogin) async {
    if (!isValid) return;

    state = state.copyWith(isLoading: true);

    final params = LoginParams(
      email: state.email,
      password: state.password,
    );

    final result = await postLogin.call(params);

    state = state.copyWith(isLoading: false);

    result.fold(
      (failure) => throw failure, // Let the UI handle the error
      (_) => null, // Navigation will be handled by router
    );
  }
}
