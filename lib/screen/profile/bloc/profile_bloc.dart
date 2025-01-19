import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/models/user_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<UpdateProfile>(_updateProfile);
  }
  FutureOr<void> _updateProfile(
      UpdateProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final doc = FirebaseFirestore.instance
          .collection('users')
          .doc(event.request.id);
      await doc.set(event.request.toJson());
      final docSnapshot = await doc.get();
      final profileData = docSnapshot.data();
      if (profileData != null) {
        emit(ProfileUpdated(
            UserModel.fromJson(profileData).copyWith(id: doc.id)));
      } else {
        emit(const ProfileUpdateFailed('Failed to update profile'));
      }
    } on Exception catch (e) {
      print(e);
      emit(ProfileUpdateFailed(e.toString()));
    } catch (e) {
      print(e);
      emit(ProfileUpdateFailed(e.toString()));
    }
  }
}
