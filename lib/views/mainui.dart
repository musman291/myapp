import 'package:flutter/material.dart';
import 'package:myappac/constants/constant.dart';
import 'package:myappac/enum/enum.dart';
import 'package:myappac/services/auth/auth_services.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        backgroundColor: Colors.blueAccent,
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final signout = await Logout(context);
                  if (signout) {
                    await AuthServices.firebase().logout();
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil(loginroute, (_) => false);
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
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
