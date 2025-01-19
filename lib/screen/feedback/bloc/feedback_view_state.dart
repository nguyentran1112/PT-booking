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
}
