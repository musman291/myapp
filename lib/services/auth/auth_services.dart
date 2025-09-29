import 'package:myappac/services/auth/auth_provider.dart';
import 'package:myappac/services/auth/auth_user.dart';
import 'package:myappac/services/auth/firebase_provider.dart';

class AuthServices implements AuthProvider {
  final AuthProvider provider;

  AuthServices({required this.provider});

  factory AuthServices.firebase() => AuthServices(provider: FirebaseAuthProvider());

  @override
  AuthUser? get currentuser => provider.currentuser;

  @override
  Future<AuthUser> login({required email, required password}) =>
      provider.login(email: email, password: password);

  @override
  Future<void> logout() => provider.logout();

  @override
  Future<AuthUser> register({required email, required password}) =>
      provider.register(email: email, password: password);

  @override
  Future<void> sendverificationemail() => provider.sendverificationemail();

  @override
  Future<void> initialize() {
    return provider.initialize();
  }
}
