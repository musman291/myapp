import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registerview extends StatefulWidget {
  const Registerview({super.key});

  @override
  State<Registerview> createState() => _RegisterviewState();
}

class _RegisterviewState extends State<Registerview> {
  late final TextEditingController mail;
  late final TextEditingController password;
  @override
  void initState() {
    mail = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    mail.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          TextField(
            controller: mail,
            obscureText: false,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: ("Enter your mail")),
          ),
          TextField(
            controller: password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(hintText: ("Enter your password")),
          ),
          TextButton(
            onPressed: () async {
              final email = mail.text;
              final passcode = password.text;
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: passcode,
                );
              } on FirebaseAuthException {}
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 255, 255, 255),
              backgroundColor: const Color.fromARGB(255, 39, 232, 59),
            ),
            child: const Text("Register"),
          ),
        ],
      ),
    );
  }
}