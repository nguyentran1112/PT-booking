import 'package:fitness/screen/booking/booking_card.dart';
import 'package:fitness/screen/booking/booking_list/bloc/booking_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingHistory extends StatefulWidget {
  const BookingHistory({super.key});

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  late BookingListBloc _bookingListBloc;
  @override
  void initState() {
    _bookingListBloc = BookingListBloc();
    // _bookingListBloc.add(const FetchBookingList());
    super.initState();
  }

  @override
  void dispose() {
    _bookingListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bookingListBloc,
      child: BlocConsumer<BookingListBloc, BookingListState>(
        listener: (context, state) {
          if (state.message.isNotEmpty && state.status == BookingListStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.bookings.length + 1,
            itemBuilder: (context, index) {
              if (index >= state.bookings.length) {
                if (state.hasMore) {
                  return Container(
                    alignment: Alignment.center,
                    width: 24,
                    height: 24,
                    child: const CircularProgressIndicator(),
                  );
                } else {
                  if (state.bookings.isEmpty) {
                    return const BookingEmpty();
                  }
                  return const SizedBox();
                }
              }
              return BookingCard(data: state.bookings[index]);
            },
          );
        },
      ),
    );
  }
}
