import 'package:flutter/material.dart';
import 'package:myappac/constants/constant.dart';
import 'package:myappac/services/auth/auth_exception.dart';
import 'package:myappac/services/auth/auth_services.dart';
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
                await AuthServices.firebase().login(email: email, password: passcode,);
                final user = AuthServices.firebase().currentuser;
                if(user?.verified ?? false )
                {
                  Navigator.of(context).pushNamedAndRemoveUntil(welcomeroute, (route) => false,);
                }
                else
                {
                  Navigator.of(
                  context
                ).pushNamedAndRemoveUntil(verifyemailroute, (route) => false,);
                }
              } on InvalidcredentialException {
                 await showErrorDialog(context, 'Invalid Credential');
              } 
              on GenericException {
                  await showErrorDialog(context, 'Authentication Error');
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
                registerroute,
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
