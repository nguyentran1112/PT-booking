import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/models/feedback_model.dart';

part 'feedback_view_event.dart';
part 'feedback_view_state.dart';

class FeedbackViewBloc extends Bloc<FeedbackViewEvent, FeedbackViewState> {
  final String userId;
  FeedbackViewBloc({
    required this.userId,
  }) : super(FeedbackViewState()) {
    on<LoadFeedbacks>(_loadFeedback);
    on<LoadMoreFeedbacks>(_loadMoreFeedback);
  }

  FutureOr<void> _loadFeedback(
      LoadFeedbacks event, Emitter<FeedbackViewState> emit) {}

  FutureOr<void> _loadMoreFeedback(
      LoadMoreFeedbacks event, Emitter<FeedbackViewState> emit) {}
}
