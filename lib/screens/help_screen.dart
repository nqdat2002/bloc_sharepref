import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(title: const Text('Help'), backgroundColor: Colors.red.shade700),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          const ListTile(leading: Icon(Icons.help_outline), title: Text('How to use the app')),
          const Divider(),
          Text('If you need assistance, contact support@example.com', style: TextStyle(color: Colors.red.shade700.withOpacity(0.9))),
        ]),
      ),
    );
  }
}