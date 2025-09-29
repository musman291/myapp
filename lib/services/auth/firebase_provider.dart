import 'package:firebase_core/firebase_core.dart';
import 'package:myappac/firebase_options.dart';
import 'package:myappac/services/auth/auth_exception.dart';
import 'package:myappac/services/auth/auth_provider.dart';
import 'package:myappac/services/auth/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;

class FirebaseAuthProvider implements AuthProvider {
  @override
  AuthUser? get currentuser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> login({required email, required password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentuser;
      if (user != null) {
        return user;
      } else {
        throw GenericException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        throw InvalidcredentialException();
      } else {
        throw GenericException();
      }
    } catch (_) {
      throw GenericException();
    }
  }

  @override
  Future<void> logout() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw GenericException();
    }
  }

  @override
  Future<AuthUser> register({required email, required password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentuser;
      if (user != null) {
        return user;
      } else {
        throw GenericException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'channel-error') {
        throw InvalidFormatException();
      } else if (e.code == 'weak-password') {
        throw WeakpasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailinUseException();
      } else {
        throw GenericException();
      }
    } catch (_) {
      throw GenericException();
    }
  }

  @override
  Future<void> sendverificationemail() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw GenericException();
    }
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }
}
