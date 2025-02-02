import 'package:fitness/common/top_tab_bar_common.dart';
import 'package:fitness/screen/booking/booking_history.dart';
import 'package:fitness/screen/booking/booking_list/booking_view.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          TopTabBarCommon(
              tabs: const [
                'Đặt lịch',
                'Lịch sử',
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              }),
          const SizedBox(
            height: 6,
          ),
          Expanded(child: _buildBody())
        ],
      ),
    );
  }
  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return const BookingList();
      case 1:
        return const BookingHistory();
      default:
        return const BookingList();
    }
  }
}
