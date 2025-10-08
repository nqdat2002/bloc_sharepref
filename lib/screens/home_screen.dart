import 'package:bloc_sharepref/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String message = "";

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is String) {
      Map? pushArguments = arguments as Map?;

      setState(() {
        message = pushArguments?['message'] ?? "";
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LoggedOut());
            },
          ),

          IconButton(
            onPressed: (){

            }, 
            icon: const Icon(Icons.notifications),
          )
        ],
      ),
      body: const Center(
        child: Text(
          "Welcome! You are logged in.",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}