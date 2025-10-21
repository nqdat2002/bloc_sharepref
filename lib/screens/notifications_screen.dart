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
    // có thể nhận String (json), Map hoặc other
    if (arguments is String) {
      display = arguments;
    } else if (arguments is Map) {
      final msg = arguments['message'];
      if (msg is String) {
        // nếu là json string, cố gắng decode để hiển thị đẹp hơn
        try {
          final decoded = json.decode(msg);
          if (decoded is Map || decoded is List) {
            display = const JsonEncoder.withIndent('  ').convert(decoded);
          } else {
            display = msg;
          }
        } catch (_) {
          display = msg;
        }
      } else {
        display = arguments.toString();
      }
      // hiển thị notification title/body nếu có
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

    setState(() {
      message = display;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        title: const Text("Notifications Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            message.isEmpty ? "No push message data" : message,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}