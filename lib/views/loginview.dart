import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myappac/constants/constant.dart';
import 'package:myappac/utilities/error_dialog.dart';

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
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
        title: const Text('Login'),
        backgroundColor: Colors.blueAccent,
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
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: passcode,
                );
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(welcome, (route) => false);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'invalid-credential') {
                  await showErrorDialog(context, 'Invalid Credential');
                }
                else {
                  await showErrorDialog(context,
                  'Error: ${e.code}');
                }
              } catch (e)
              {
                await showErrorDialog(context,
                  e.toString(),);
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 255, 255, 255),
              backgroundColor: const Color.fromARGB(255, 39, 232, 59),
            ),
            child: const Text("Login"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                register,
                (keepPreviousActive) => false,
              );
            },
            child: const Text("Not Registered?Click Here"),
          ),
        ],
      ),
    );
  }
}