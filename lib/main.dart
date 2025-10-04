import 'package:bloc_sharepref/blocs/authentication_bloc.dart';
import 'package:bloc_sharepref/screens/auth_page_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth_bloc.dart' hide AuthInitial;
import 'repositories/auth_repository.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthRepository authRepository;
  late final AuthBloc auth;
  @override
  void initState() {
    authRepository = AuthRepository();
    auth = AuthBloc(authRepository)..add(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => auth),
        BlocProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc(
            authBloc: auth,
            authRepository: authRepository,
          ),
        ),
        // Các bloc khác nếu có
      ],
      child: MaterialApp(
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is Authenticated) {
              return const HomeScreen();
            } else {
              return const AuthPageSwitcher();
            }
          },
        ),
      ),
    );
  }
}
