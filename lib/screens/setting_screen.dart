import 'package:flutter/material.dart';
import 'widgets/profile_header.dart';
import 'widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cài đặt')),
      body: ListView(
        children: const [
          ProfileHeader(
            name: 'Nguyễn Quốc Đạt',
            email: 'quocdat@example.com',
            avatarUrl: 'https://i.pravatar.cc/150?img=3',
          ),
          Divider(),
          SettingsTile(icon: Icons.lock, title: 'Đổi mật khẩu'),
          SettingsTile(icon: Icons.notifications, title: 'Thông báo'),
          SettingsTile(icon: Icons.language, title: 'Ngôn ngữ'),
          SettingsTile(icon: Icons.logout, title: 'Đăng xuất'),
        ],
      ),
    );
  }
}