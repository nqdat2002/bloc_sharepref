import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(title: const Text('About'), backgroundColor: Colors.red.shade700),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('About this app', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('This is a demo app built with Flutter. Replace this text with your app description.', style: TextStyle(color: Colors.red.shade700.withOpacity(0.9))),
          const SizedBox(height: 16),
          ListTile(leading: const Icon(Icons.code), title: const Text('Version'), subtitle: const Text('1.0.0')),
          ListTile(leading: const Icon(Icons.privacy_tip), title: const Text('Privacy'), onTap: () {}),
        ]),
      ),
    );
  }
}