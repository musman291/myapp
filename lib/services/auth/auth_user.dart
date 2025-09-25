import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/widgets.dart';

@immutable
class AuthUser{
  final bool verified;

  const AuthUser(this.verified);
  factory AuthUser.fromFirebase(User user) =>
      AuthUser(user.emailVerified);
}
