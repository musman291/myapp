import 'package:flutter/material.dart';
import 'package:myappac/constants/constant.dart';
import 'package:myappac/services/auth/auth_services.dart';
import 'package:myappac/views/loginview.dart';
import 'package:myappac/views/mainui.dart';
import 'package:myappac/views/registerview.dart';
import 'package:myappac/views/verifyemail.dart';

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
        loginroute: (context) => const Loginview(),
        registerroute: (context) => const Registerview(),
        welcomeroute: (context) => const Welcome(),
        verifyemailroute : (context) => const VerifyEmail(),
      },
    ),
  );
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthServices.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthServices.firebase().currentuser;
            if (user != null) {
              if (user.verified) {
                return Welcome();
              } else {
                return const VerifyEmail();
              }
            } else {
              return  Registerview();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}