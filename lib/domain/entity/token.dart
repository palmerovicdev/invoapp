import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/token.freezed.dart';
part 'gen/token.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class Token with _$Token {
  Token({
    required this.token,
    this.expiresAt,
  });

  @override
  final String token;
  @override
  final DateTime? expiresAt;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  bool get isValid => token.isNotEmpty && !isExpired;

}
