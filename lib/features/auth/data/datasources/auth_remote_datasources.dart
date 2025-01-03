import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:resto_lite/core/core.dart';
import 'package:resto_lite/features/features.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_remote_datasources.g.dart';

abstract class AuthRemoteDatasource {
  Future<Either<Failure, LoginResponse>> login(LoginParams params);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, LoginResponse>> refreshToken(
    RefreshTokenParams refreshToken,
  );
  Future<Either<Failure, void>> updatePassword(UpdatePasswordParams params);
  Future<Either<Failure, void>> subscribe(String token);
}

@RestApi()
abstract class AuthRemoteClient {
  factory AuthRemoteClient(Dio dio, {String baseUrl}) = _AuthRemoteClient;

  @POST(ListAPI.login)
  Future<LoginResponse> login(@Body() Map<String, dynamic> params);

  @POST(ListAPI.logout)
  Future<void> logout(@Body() Map<String, dynamic> params);

  @POST(ListAPI.refreshToken)
  Future<LoginResponse> refreshToken(@Body() Map<String, dynamic> params);

  @POST(ListAPI.subscribe)
  Future<void> subscribe(@Body() Map<String, String> params);

  @POST(ListAPI.updatePassword)
  Future<void> updatePassword(@Body() Map<String, dynamic> params);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final AuthRemoteClient _client;

  AuthRemoteDatasourceImpl(this._client);

  @override
  Future<Either<Failure, LoginResponse>> login(LoginParams params) async {
    try {
      final response = await _client.login({
        'username': params.email,
        'password': params.password,
      });
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _client.logout({
        'registration_token': null,
      });
      return const Right(null);
    } on DioException catch (e) {
      return Left(Failure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> refreshToken(
    RefreshTokenParams refreshToken,
  ) async {
    try {
      final response = await _client.refreshToken(refreshToken.toJson());
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePassword(
    UpdatePasswordParams params,
  ) async {
    try {
      await _client.updatePassword(params.toJson());
      return const Right(null);
    } on DioException catch (e) {
      return Left(Failure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> subscribe(String token) async {
    try {
      await _client.subscribe({'token': token});
      return const Right(null);
    } on DioException catch (e) {
      return Left(Failure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
