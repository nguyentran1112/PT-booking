import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/models/feedback_model.dart';
import 'package:fitness/models/user_model.dart';

part 'feedback_view_event.dart';
part 'feedback_view_state.dart';

class FeedbackViewBloc extends Bloc<FeedbackViewEvent, FeedbackViewState> {
  final String userId;
  final feedBackFirestore = FirebaseFirestore.instance.collection('feedback');
  DocumentSnapshot<Object?>? lastDocument;
  FeedbackViewBloc({
    required this.userId,
  }) : super(FeedbackViewState()) {
    on<LoadFeedbacks>(_loadFeedback);
    on<LoadMoreFeedbacks>(_loadMoreFeedback);
    on<AddNewFeedback>(_createFeedBack);
  }

  FutureOr<void> _loadFeedback(
      LoadFeedbacks event, Emitter<FeedbackViewState> emit) async {
    emit(state.copyWith(
        status: FeedbackViewStatus.loading, feedbacks: [], hasMore: true));
    lastDocument = null;
    try {
      final querySnapshot = await feedBackFirestore
          .where('user_id', isEqualTo: userId)
          .orderBy('created_at', descending: true)
          .limit(10)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;
        List<FeedbackModel> feedbacks = [];
        for (var doc in querySnapshot.docs) {
          final data = doc.data();
          FeedbackModel feedbackModel = FeedbackModel.fromJson(data);
          feedbacks.add(feedbackModel);
        }
        for (var feedback in feedbacks) {
          if (checkUserExist(feedback.createdBy ?? '')) {
            feedback.user = getUser(feedback.createdBy ?? '');
            continue;
          }
          final userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(feedback.createdBy)
              .get();
          if (userDoc.exists) {
            feedback.user = UserModel.fromJson(userDoc.data()!);
          }
        }

        emit(state.copyWith(
            status: FeedbackViewStatus.loaded,
            feedbacks: feedbacks,
            hasMore: feedbacks.length == 10));
      } else {
        emit(state.copyWith(
            status: FeedbackViewStatus.loaded, feedbacks: [], hasMore: false));
      }
      emit(state.copyWith(status: FeedbackViewStatus.loaded));
    } catch (e) {
      emit(state.copyWith(
          status: FeedbackViewStatus.error, message: e.toString()));
    }
  }

  bool checkUserExist(String userId) {
    return state.feedbacks.any((element) => element.createdBy == userId);
  }

  UserModel? getUser(String userId) {
    return state.feedbacks
        .firstWhere((element) => element.createdBy == userId)
        .user;
  }

  FutureOr<void> _loadMoreFeedback(
      LoadMoreFeedbacks event, Emitter<FeedbackViewState> emit) async {
    if (state.hasMore) {
      feedBackFirestore
          .where('user_id', isEqualTo: userId)
          .orderBy('created_at', descending: true)
          .startAfterDocument(lastDocument!)
          .limit(10)
          .get()
          .then((querySnapshot) async {
        if (querySnapshot.docs.isNotEmpty) {
          lastDocument = querySnapshot.docs.last;
          List<FeedbackModel> feedbacks = [...state.feedbacks];
          for (var doc in querySnapshot.docs) {
            final data = doc.data();
            FeedbackModel feedbackModel = FeedbackModel.fromJson(data);
            feedbacks.add(feedbackModel);
          }
          for (var feedback in feedbacks) {
            if (checkUserExist(feedback.createdBy ?? '')) {
              feedback.user = getUser(feedback.createdBy ?? '');
              continue;
            }
            final userDoc = await FirebaseFirestore.instance
                .collection('users')
                .doc(feedback.createdBy)
                .get();
            if (userDoc.exists) {
              feedback.user = UserModel.fromJson(userDoc.data()!);
            }
          }
          emit(state.copyWith(
            status: FeedbackViewStatus.loaded,
            feedbacks: feedbacks,
          ));
        } else {
          emit(state.copyWith(hasMore: false));
        }
      }).catchError((e) {
        emit(state.copyWith(
            status: FeedbackViewStatus.error, message: e.toString()));
      });
    }
  }

  FutureOr<void> _createFeedBack(AddNewFeedback event, Emitter emit) async {
    List<FeedbackModel> feedbacks = [];
    feedbacks.addAll(state.feedbacks);
    feedbacks.insert(0, event.feedback);
    emit(state.copyWith(feedbacks: feedbacks));
  }
}
