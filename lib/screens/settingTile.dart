import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.red.shade700,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.red.shade100, child: Icon(Icons.person, color: Colors.red.shade700)),
                  title: const Text('Welcome back'),
                  subtitle: Text('Bạn đã đăng nhập thành công', style: TextStyle(color: Colors.red.shade700.withOpacity(0.8))),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: 8,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.red.shade100, child: Icon(Icons.star, color: Colors.red.shade700)),
                    title: Text('Item ${index + 1}'),
                    subtitle: const Text('Mô tả ngắn'),
                    trailing: Icon(Icons.chevron_right, color: Colors.red.shade700),
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}