part of 'create_feedback_bloc.dart';

sealed class CreateFeedbackEvent extends Equatable {
  const CreateFeedbackEvent();

  @override
  List<Object> get props => [];
}

final class CreateFeedback extends CreateFeedbackEvent {
  final FeedbackModel feedback;
  const CreateFeedback(this.feedback);
}
