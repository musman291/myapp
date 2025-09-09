import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myappac/loginview.dart';
import 'package:myappac/registerview.dart';
import 'package:myappac/verifyemail.dart';
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
        'register': (context) {
          return const Registerview();
        },
      },
    ),
  );
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                return mainui();
              } else {
                return const VerifyEmail();
              }
            } else {
              return const Registerview();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

enum Action { logout }

class mainui extends StatefulWidget {
  const mainui({super.key});

  @override
  State<mainui> createState() => _mainuiState();
}

class _mainuiState extends State<mainui> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        backgroundColor: Colors.blueAccent,
        actions: [
          PopupMenuButton<Action>(
            onSelected: (value) async {
              switch (value) {
                case Action.logout:
                  final signout = await Logout(context);
                  if (signout) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil('login', (_) => false);
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<Action>(
                  value: Action.logout,
                  child: Text('LogOut'),
                ),
              ];
            },
          ),
        ],
      ),
      body: const Text('How are you?'),
    );
  }
}

Future<bool> Logout(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('LogOut'),
        content: const Text('Are you sure?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
