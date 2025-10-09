import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String message = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null) {
      Map? pushArguments = arguments as Map;

      setState(() {
        message = pushArguments['message'] ?? "Error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications Screen"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ],
      ),
      body: Center(
        child: Text(
          "PushMessage: $message",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}