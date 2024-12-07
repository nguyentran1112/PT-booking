part of 'booking_list_bloc.dart';

sealed class BookingListEvent extends Equatable {
  const BookingListEvent();

  @override
  List<Object> get props => [];
}

final class FetchBookingList extends BookingListEvent {
  const FetchBookingList();

  @override
  List<Object> get props => [];
}

final class FetchMoreBookingList extends BookingListEvent {
  const FetchMoreBookingList();

  @override
  List<Object> get props => [];
}
