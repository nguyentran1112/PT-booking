import 'dart:developer';

import 'package:fitness/models/booking_model.dart';
import 'package:fitness/screen/booking/booking_card.dart';
import 'package:fitness/screen/booking/booking_list/bloc/booking_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BookingList extends StatefulWidget {
  const BookingList({super.key});

  @override
  State<BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  late BookingListBloc _bookingListBloc;
  @override
  void initState() {
    _bookingListBloc = BookingListBloc();
    _bookingListBloc.add(const FetchBookingList());
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
          log(state.status.name);
          return ListView.builder(
            itemCount: state.bookings.length + 1,
            itemBuilder: (context, index) {
              if (index >= state.bookings.length) {
                if (state.hasMore) {
                  return Skeletonizer(child: BookingCard(data: BookingModel().mockData));
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
