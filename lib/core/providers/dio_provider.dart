import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resto_lite/core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
DioClient dioClientInstance(_) {
  return DioClient();
}

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final client = ref.watch(dioClientInstanceProvider);
  return client.dio;
}
