import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/models/feedback_model.dart';
import 'package:fitness/models/user_model.dart';
import 'package:uuid/uuid.dart';

part 'create_feedback_event.dart';
part 'create_feedback_state.dart';

class CreateFeedbackBloc
    extends Bloc<CreateFeedbackEvent, CreateFeedbackState> {
  CreateFeedbackBloc() : super(CreateFeedbackState()) {
    on<CreateFeedback>(_createFeedBack, transformer: droppable());
  }
  FutureOr<void> _createFeedBack(CreateFeedback event, Emitter emit) async {
    emit(state.copyWith(status: CreateFeedbackStatus.loading));
    try {
      final String uuid = Uuid().v4();
      final feedBack =
          FirebaseFirestore.instance.collection('feedback').doc(uuid);
      FeedbackModel feedback = event.feedback;
      DateTime now = DateTime.now();
      feedback.createdAt = now;
      feedback.updatedAt = now;
      feedback.id = uuid;
      feedback.hidden = false;
      await feedBack.set(feedback.toJson());
      final user =
          FirebaseFirestore.instance.collection('users').doc(feedback.userId);
      user.get().then((value) {
        feedback.user = UserModel.fromJson(value.data()!);
        user.update(
            {'total_rating': FieldValue.increment(feedback.rating ?? 0)});
      });
      emit(state.copyWith(
          status: CreateFeedbackStatus.success, feedback: feedback));
    } catch (e) {
      emit(state.copyWith(
          status: CreateFeedbackStatus.error, message: e.toString()));
    }
  }
}
