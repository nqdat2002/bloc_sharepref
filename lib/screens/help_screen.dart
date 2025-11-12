import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: const Text('Help'),
        backgroundColor: Colors.red.shade700,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          const ListTile(leading: Icon(Icons.help_outline), title: Text('How to use the app')),
          const Divider(),
          Text(
            'Nếu cần trợ giúp hãy liên hệ support@example.com',
            style: TextStyle(color: Colors.red.shade700.withOpacity(0.9)),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade700),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gọi support (demo)')));
            },
            icon: const Icon(Icons.contact_support),
            label: const Text('Contact Support'),
          ),
        ]),
      ),
    );
  }
}