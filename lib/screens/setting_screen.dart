import 'package:bloc_sharepref/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/profile_header.dart';
import 'widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ProfileHeader(
            name: 'Nguyễn Quốc Đạt',
            email: 'datnq2762@gmail.com',
            avatarUrl: 'https://i.pravatar.cc/150?img=3',
          ),
          Divider(),
          SettingsTile(icon: Icons.lock, title: 'Change password'),
          SettingsTile(icon: Icons.notifications, title: 'Notifications settings'),
          SettingsTile(icon: Icons.language, title: 'Language'),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              context.read<AuthBloc>().add(LoggedOut());
            },
          ),
        ],
      ),
    );
  }
}