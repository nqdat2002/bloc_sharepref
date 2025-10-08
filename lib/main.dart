import 'dart:convert';

import 'package:bloc_sharepref/blocs/authentication_bloc.dart';
import 'package:bloc_sharepref/screens/auth_page_switcher.dart';
import 'package:bloc_sharepref/screens/empty_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth_bloc.dart' hide AuthInitial;
import 'repositories/auth_repository.dart';
import 'screens/home_screen.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.instance.getToken().then((value) {
    print("Firebase Messaging Token: $value");
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    print("On Message: $message");
    Navigator.pushNamed(navigatorKey.currentContext!, '/push-page', arguments: {
      'message': json.encode(message.data),
    });
  });


  FirebaseMessaging.instance.getInitialMessage().then((message) {
    if (message != null) {
      print("Initial Message: $message");
      Navigator.pushNamed(navigatorKey.currentContext!, '/push-page', arguments: {
        'message': json.encode(message.data),
      });
    }
  });

  FirebaseMessaging.onBackgroundMessage((_firebaseHandler));

  runApp(const MyApp());
}

Future<void> _firebaseHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
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
        navigatorKey: navigatorKey,
        routes: {
          '/': (context) => const EmptyScreen(),
          '/push-page': (context) => const HomeScreen(),
        },
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
