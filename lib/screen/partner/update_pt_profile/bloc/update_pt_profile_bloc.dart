import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/models/user_model.dart';

part 'update_pt_profile_event.dart';
part 'update_pt_profile_state.dart';

class UpdatePtProfileBloc
    extends Bloc<UpdatePtProfileEvent, UpdatePtProfileState> {
  UpdatePtProfileBloc() : super(UpdatePtProfileState()) {
    on<LoadProfile>(_loadProfile);
  }
  FutureOr<void> _loadProfile(LoadProfile event, Emitter emit) async {
    emit(state.copyWith(status: UpdatePtProfileStatus.loading));
    try {
      final userCollection = FirebaseFirestore.instance.collection('users');
      final userDoc = await userCollection.doc(event.id).get();
      if (userDoc.exists) {
        final user = UserModel.fromJson(userDoc.data()!);
        emit(state.copyWith(status: UpdatePtProfileStatus.success, user: user));
      } else {
        emit(state.copyWith(
            status: UpdatePtProfileStatus.error, message: 'User not found'));
      }
    } catch (e) {
      emit(state.copyWith(
          status: UpdatePtProfileStatus.error, message: e.toString()));
    }
  }
}
