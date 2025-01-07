import 'package:fitness/screen/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:fitness/screen/booking/booking_screen.dart';
import 'package:fitness/screen/bottom_bar_icon.dart';
import 'package:fitness/screen/favorite/favorite_screen.dart';
import 'package:fitness/screen/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = <Widget>[
    const HomeScreen(),
    const FavoriteScreen(),
    const BookingScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];
  int _currentIndex = 0;
  late AuthenticationBloc _authenticationBloc;
  void _onItemTapped(int index) {
    if (mounted) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    // if (_authenticationBloc.state is Unauthenticated) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     context.pushReplacement(RouterConstants.login.path);
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomBarIcon(
        icons: const <String>[
          'assets/search.svg',
          'assets/heart.svg',
          'assets/id_card.svg',
          'assets/chat.svg',
          'assets/user_profile.svg',
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}