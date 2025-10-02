// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trang chủ khi đã đăng nhập')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Đăng xuất'),
          onPressed: () {
            context.read<AuthBloc>().add(LoggedOut());
          },
        ),
      ),
    );
  }
}