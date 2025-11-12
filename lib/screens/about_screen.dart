import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.red.shade700,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('About this app', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(
            'Demo app built with Flutter. Thay nội dung này bằng mô tả thật của bạn.',
            style: TextStyle(color: Colors.red.shade700.withOpacity(0.9)),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: const [
                ListTile(leading: Icon(Icons.code), title: Text('Version'), subtitle: Text('1.0.0')),
                Divider(height: 0),
                ListTile(leading: Icon(Icons.privacy_tip), title: Text('Privacy'), subtitle: Text('Policy...')),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}