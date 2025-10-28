import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/user.freezed.dart';
part 'gen/user.g.dart';

@freezed
@JsonSerializable()
class User with _$User {
  User({
    required this.email,
    @Default(false) this.isLoggedIn = false,
    this.lastLogin,
  });

  @override
  final String email;
  @override
  final bool isLoggedIn;
  @override
  final DateTime? lastLogin;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  static User mock() => User(
    email: 'user@homemock.com',
    isLoggedIn: true,
    lastLogin: DateTime.now(),
  );
}