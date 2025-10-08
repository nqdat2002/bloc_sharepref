import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:  Scaffold(
      body: Center(
          child: const Text("No Data"),
      ),
    ));
  }
}