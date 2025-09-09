import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myappac/loginview.dart';
import 'package:myappac/registerview.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter course',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 111, 208, 220),
        ),
      ),
      home: const Homepage(),
      routes: {
        'login': (context) => const Loginview(),
        'register': (context) { return const Registerview(); },
      },
    ),
  );
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              //final user = FirebaseAuth.instance.currentUser;
              //final verified = user?.emailVerified ?? false;
              //if (verified) {
              //} else {
                //return const VerifyEmail();
              //}
              return const Loginview();
            default:
              return const CircularProgressIndicator();
          }
        },
      );
  }
}
