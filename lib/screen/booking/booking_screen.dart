import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: <Widget>[
          Text('Đặt lich', style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),),
        ],
      ),
    );
  }
}