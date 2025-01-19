// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_feedback_bloc.dart';

enum CreateFeedbackStatus { initial, loading, success, error }

class CreateFeedbackState extends Equatable {
  const CreateFeedbackState({
    this.status = CreateFeedbackStatus.initial,
    this.message = '',
    this.feedback,
  });
  final CreateFeedbackStatus status;
  final String message;
  final FeedbackModel? feedback;
  @override
  List<Object?> get props => [
        status,
        message,
        feedback,
      ];

  CreateFeedbackState copyWith({
    CreateFeedbackStatus? status,
    String? message,
    FeedbackModel? feedback,
  }) {
    return CreateFeedbackState(
      status: status ?? this.status,
      message: message ?? this.message,
      feedback: feedback ?? this.feedback,
    );
  }
}
