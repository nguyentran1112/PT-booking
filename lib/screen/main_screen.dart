import 'package:fitness/routing/router_constants.dart';
import 'package:fitness/screen/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:fitness/screen/booking/booking_screen.dart';
import 'package:fitness/screen/home_screen.dart';
import 'package:fitness/screen/search/view/search_screen.dart';
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
    const SearchScreen(),
    const BookingScreen(),
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
    if (_authenticationBloc.state is Unauthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.pushReplacement(RouterConstants.login.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}