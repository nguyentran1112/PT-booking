import 'package:fitness/routing/router_constants.dart';
import 'package:fitness/screen/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui'; // To use the ImageFilter

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final bool _isLoading = false; // Simulating loading, change when needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccess) {
            context.pushReplacementNamed(RouterConstants.home.name);
          }
        },
        child: Stack(
          children: [
            // Background Image with Blur Effect
            Positioned.fill(
              child: Image.asset(
                'background.jpg', // Add your image here
                fit: BoxFit.cover,
              ),
            ),
            // Apply the blur effect
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Adjust blur strength here
                child: Container(
                  color: Colors.black.withOpacity(0.4), // Semi-transparent overlay
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Sign in to continue to your PT booking',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // If loading, show a circular progress indicator
                    if (_isLoading)
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                      )
                    else
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<AuthenticationBloc>().add(LoginWithGoogle());
                        },
                        icon: const Icon(Icons.login, color: Colors.white),
                        label: const Text(
                          'Login with Google',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrangeAccent, // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30), // Rounded corners
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          textStyle: const TextStyle(fontSize: 18),
                          elevation: 5, // Adding shadow to button
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
