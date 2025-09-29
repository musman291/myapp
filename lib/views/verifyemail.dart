import 'package:flutter/material.dart';
import 'package:myappac/constants/constant.dart';
import 'package:myappac/services/auth/auth_services.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          const Text("Email verification sent"),
          const Text("If not received click below"),
          TextButton(
            onPressed: () async {
              AuthServices.firebase().sendverificationemail();
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 255, 255, 255),
              backgroundColor: Colors.blueAccent,
            ),
            child: const Text("Send Link"),
          ),
          TextButton(
            onPressed: () async {
              await AuthServices.firebase().logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerroute,
                (keepPreviousActive) => false,
              );
            },
            child: const Text("Go Back"),
          ),
        ],
      ),
    );
  }
}
