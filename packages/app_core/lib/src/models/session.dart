import 'app_user.dart';

class Session {
  const Session({required this.user, required this.token});

  final AppUser user;
  final String token;

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      user: AppUser.fromJson(json['user'] as Map<String, dynamic>? ?? const {}),
      token: (json['token'] ?? '') as String,
    );
  }
}
