import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/models/booking_model.dart';
import 'package:fitness/models/user_model.dart';

part 'booking_list_event.dart';
part 'booking_list_state.dart';

class BookingListBloc extends Bloc<BookingListEvent, BookingListState> {
  BookingListBloc() : super(const BookingListState()) {
    on<FetchBookingList>(_loadBookingList);
    on<FetchMoreBookingList>(_loadMoreBookingList);
  }

  FutureOr<void> _loadBookingList(BookingListEvent event, Emitter<BookingListState> emit) async {
    try {
      emit(state.copyWith(status: BookingListStatus.loading, hasMore: true));
      await Future.delayed(const Duration(seconds: 2));
      List<BookingModel> bookings = List.generate(10, (index) {
        return BookingModel(
          id: index.toString(),
          address: 'Hà Nội',
          partner: UserModel().mockData,
          time: DateTime.now().add(Duration(days: index)),
        );
      });
      emit(state.copyWith(
        bookings: bookings,
        hasMore: true,
        page: 0,
        pageSize: 10,
        status: BookingListStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: BookingListStatus.error));
    }
  }

  FutureOr<void> _loadMoreBookingList(BookingListEvent event, Emitter<BookingListState> emit) async {
    try {
      emit(state.copyWith(status: BookingListStatus.loading));
      await Future.delayed(const Duration(seconds: 2));
      List<BookingModel> bookings = List.generate(10, (index) {
        return BookingModel(
          id: index.toString(),
          address: 'Hà Nội',
          partner: UserModel().mockData,
          time: DateTime.now().add(Duration(days: index)),
        );
      });
      emit(state.copyWith(
        bookings: [...state.bookings, ...bookings],
        hasMore: false,
        page: state.page + 1,
        pageSize: 10,
        status: BookingListStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: BookingListStatus.error));
    }
  }
}
