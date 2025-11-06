import 'package:bloc_sharepref/blocs/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onSwitchToSignUp;

  const LoginScreen({super.key, required this.onSwitchToSignUp});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true; // Default to obscure password

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.red.shade700,
        elevation: 0,
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
            child: SingleChildScrollView(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.red.shade100,
                        child: Icon(Icons.lock_outline, size: 40, color: Colors.red.shade700),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade700,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.person, color: Colors.red),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red.shade700),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock, color: Colors.red),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red.shade700),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              color: Colors.red.shade700,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscurePassword,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Colors.red.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            context.read<AuthenticationBloc>().add(
                                  LoginRequested(
                                    username: _usernameController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: widget.onSwitchToSignUp,
                        child: Text(
                          "Don't have an account? Sign Up",
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}