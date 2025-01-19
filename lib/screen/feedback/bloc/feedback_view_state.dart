// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'feedback_view_bloc.dart';

enum FeedbackViewStatus { initial, loading, loaded, error }

class FeedbackViewState extends Equatable {
  const FeedbackViewState({
    this.message = '',
    this.status = FeedbackViewStatus.initial,
    this.feedbacks = const [],
    this.pageNum = 0,
    this.pageSize = 10,
    this.hasMore = true,
  });
  final String message;
  final FeedbackViewStatus status;
  final List<FeedbackModel> feedbacks;
  final int pageNum;
  final int pageSize;
  final bool hasMore;
  @override
  List<Object> get props => [
        message,
        status,
        feedbacks,
      ];

  FeedbackViewState copyWith({
    String? message,
    FeedbackViewStatus? status,
    List<FeedbackModel>? feedbacks,
    int? pageNum,
    int? pageSize,
    bool? hasMore,
  }) {
    return FeedbackViewState(
      message: message ?? this.message,
      status: status ?? this.status,
      feedbacks: feedbacks ?? this.feedbacks,
      pageNum: pageNum ?? this.pageNum,
      pageSize: pageSize ?? this.pageSize,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
