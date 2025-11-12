import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String name = 'Người dùng';
    const String email = 'user@example.com';
    const String avatar = 'https://i.pravatar.cc/150?img=3';

    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.red.shade700,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edit profile (demo)'))),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(children: [
            CircleAvatar(radius: 40, backgroundImage: NetworkImage(avatar), backgroundColor: Colors.red.shade100),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(email, style: TextStyle(color: Colors.red.shade700.withOpacity(0.8))),
              ]),
            ),
          ]),
          const SizedBox(height: 20),
          Card(
            child: Column(
              children: [
                ListTile(leading: const Icon(Icons.person), title: const Text('Account'), subtitle: const Text('Manage account')),
                const Divider(height: 0),
                ListTile(leading: const Icon(Icons.lock), title: const Text('Change password')),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade700),
            onPressed: () {
              // logout demo
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logout pressed (demo)')));
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}