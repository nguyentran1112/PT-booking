// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'booking_list_bloc.dart';

enum BookingListStatus { initial, loading, loaded, error }

class BookingListState extends Equatable {
  final List<BookingModel> bookings;
  final bool hasMore;
  final int page;
  final int pageSize;
  final BookingListStatus status;
  final String message;
  const BookingListState({
    this.bookings = const [],
    this.hasMore = false,
    this.page = 1,
    this.pageSize = 10,
    this.status = BookingListStatus.initial,
    this.message = '',
  });
  @override
  List<Object> get props => [
        bookings,
        hasMore,
        page,
        pageSize,
        status,
        message,
      ];

  BookingListState copyWith({
    List<BookingModel>? bookings,
    bool? hasMore,
    int? page,
    int? pageSize,
    BookingListStatus? status,
    String? message,
  }) {
    return BookingListState(
      bookings: bookings ?? this.bookings,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
