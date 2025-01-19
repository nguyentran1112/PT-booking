part of 'feedback_view_bloc.dart';

sealed class FeedbackViewEvent extends Equatable {
  const FeedbackViewEvent();

  @override
  List<Object> get props => [];
}

final class LoadFeedbacks extends FeedbackViewEvent {
  const LoadFeedbacks();
}

final class LoadMoreFeedbacks extends FeedbackViewEvent {
  const LoadMoreFeedbacks();
}
