import 'package:flutter/material.dart';
import 'package:myappac/constants/constant.dart';
import 'package:myappac/services/auth/auth_exception.dart';
import 'package:myappac/services/auth/auth_services.dart';
import 'package:myappac/utilities/error_dialog.dart';

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
        title: const Text('Register'),
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
                await AuthServices.firebase().register(
                  email: email,
                  password: passcode,
                );
                AuthServices.firebase().sendverificationemail();
                Navigator.of(context).pushNamed(verifyemailroute);
              } on InvalidFormatException {
                await showErrorDialog(context, 'Invalid Format');
              } 
              on WeakpasswordException {
                await showErrorDialog(context, 'Weak Password');
              }
              on EmailinUseException {
                await showErrorDialog(context, 'Email already in use');
              }
              on GenericException {
                await showErrorDialog(context, 'Authentication Error');
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 255, 255, 255),
              backgroundColor: const Color.fromARGB(255, 39, 232, 59),
            ),
            child: const Text("Register"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginroute,
                (keepPreviousActive) => false,
              );
            },
            child: const Text("Already Registered?Click Here"),
          ),
        ],
      ),
    );
  }
}
