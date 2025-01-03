// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_update_password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdatePasswordParamsImpl _$$UpdatePasswordParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdatePasswordParamsImpl(
      oldPassword: json['old_password'] as String,
      newPassword: json['password'] as String,
    );

Map<String, dynamic> _$$UpdatePasswordParamsImplToJson(
        _$UpdatePasswordParamsImpl instance) =>
    <String, dynamic>{
      'old_password': instance.oldPassword,
      'password': instance.newPassword,
    };
