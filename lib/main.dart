import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth_bloc.dart';
import 'repositories/auth_repository.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthRepository authRepository;

  @override
  void initState() {
    authRepository = AuthRepository();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(authRepository)..add(AppStarted()),
      child: MaterialApp(
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is Authenticated) {
              return const HomeScreen();
            } else if (state is Unauthenticated) {
              return const LoginScreen();
            }
            return const Center(child: Text('Lỗi không xác định'));
          },
        ),
      ),
    );
  }
}