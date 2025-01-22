import 'package:fitness/routing/router_constants.dart';
import 'package:fitness/screen/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:fitness/screen/booking/booking_screen.dart';
import 'package:fitness/screen/bottom_bar_icon.dart';
import 'package:fitness/screen/home_screen/home_screen.dart';
import 'package:fitness/screen/notification/notification_screen.dart';
import 'package:fitness/screen/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = <Widget>[
    const HomeScreen(),
    const BookingScreen(),
    const NotificationScreen(),
    const ProfilePage(),
  ];
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    if (mounted) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go(RouterConstants.login.path);
          });
        }
      },
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          final user = state.user;
          if (user.isCoach!) {

          }
          return Scaffold(
            body: _screens[_currentIndex],
            backgroundColor: Colors.white,
            bottomNavigationBar: BottomBarIcon(
              icons: const <String>[
                'assets/search.svg',
                'assets/id_card.svg',
                'assets/chat.svg',
                'assets/user_profile.svg',
              ],
              onTap: _onItemTapped,
            ),
          );
        }
        return const Center(child: Text('Unknown State'));
      },
    );
  }
}
