// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
  token: json['token'] as String,
  expiresAt: json['expiresAt'] == null ? null : DateTime.parse(json['expiresAt'] as String),
);

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
  'token': instance.token,
  'expiresAt': instance.expiresAt?.toIso8601String(),
};
