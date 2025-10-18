import 'dart:convert';

import 'package:bloc_sharepref/blocs/authentication_bloc.dart';
import 'package:bloc_sharepref/screens/auth_page_switcher.dart';
import 'package:bloc_sharepref/screens/entry_point.dart';
import 'package:bloc_sharepref/screens/notifications_screen.dart';
import 'package:bloc_sharepref/screens/setting_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth_bloc.dart' hide AuthInitial;
import 'repositories/auth_repository.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission();

  FirebaseMessaging.instance.getToken().then((value) {
    if (kDebugMode) {
      print("Firebase Messaging Token: $value");
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (navigatorKey.currentContext != null) {
      showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => AlertDialog(
          title: const Text('Push Notification'),
          content: Text(
            message.notification?.body ?? 'No message',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    if (kDebugMode) {
      print("On Message OpenedApp: $message");
    }
    Navigator.pushNamed(navigatorKey.currentContext!, '/push-page', arguments: {
      'message': json.encode(message.data),
    });
  });


  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      if (kDebugMode) {
        print("On Initial Message: $message");
      }
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
  if (kDebugMode) {
    print("Handling a background message: $message");
  }
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
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        routes: {
          '/push-page': (context) => const NotificationsScreen(),
          '/setting-page': (context) => const SettingsScreen()
        },
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is Authenticated) {
              return const EntryPoint();
            } else {
              return const AuthPageSwitcher();
            }
          },
        ),

        
      ),
    );
  }
}
