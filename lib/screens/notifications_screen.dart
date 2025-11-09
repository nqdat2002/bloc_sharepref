import 'dart:convert';
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
    if (arguments == null) return;

    String display = "";
    if (arguments is String) {
      display = arguments;
    } else if (arguments is Map) {
      final msg = arguments['message'];
      if (msg is String && msg.isNotEmpty) {
        try {
          final decoded = json.decode(msg);
          display = const JsonEncoder.withIndent('  ').convert(decoded);
        } catch (_) {
          display = msg;
        }
      } else if (arguments['data'] != null) {
        display = arguments['data'].toString();
      } else {
        display = arguments.toString();
      }
      final notif = arguments['notification'];
      if (notif is Map) {
        final title = notif['title'] ?? '';
        final body = notif['body'] ?? '';
        if (title.toString().isNotEmpty || body.toString().isNotEmpty) {
          display = 'Title: $title\nBody: $body\n\nData:\n$display';
        }
      }
    } else {
      display = arguments.toString();
    }

    setState(() => message = display);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.red.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            message.isEmpty ? 'No push message data' : message,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
