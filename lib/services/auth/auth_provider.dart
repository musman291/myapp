import 'package:myappac/services/auth/auth_user.dart';

abstract class AuthProvider {
  AuthUser? get currentuser;
  Future<AuthUser> login({required email, required password,});
  Future<AuthUser> register({required email, required password,});
  Future<void> logout();
  Future<void> sendverificationemail();
  }
