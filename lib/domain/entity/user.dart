import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/user.freezed.dart';
part 'gen/user.g.dart';

@freezed
@JsonSerializable()
class User with _$User {
  User({
    required this.email,
    this.lastLogin,
  });

  @override
  final String email;
  @override
  final DateTime? lastLogin;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  static User mock() => User(
    email: 'user@homemock.com',
    lastLogin: DateTime.now(),
  );
}
