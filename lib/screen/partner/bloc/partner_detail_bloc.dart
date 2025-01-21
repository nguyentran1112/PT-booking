import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/models/user_model.dart';

part 'partner_detail_event.dart';
part 'partner_detail_state.dart';

class PartnerDetailBloc extends Bloc<PartnerDetailEvent, PartnerDetailState> {
  PartnerDetailBloc() : super(PartnerDetailInitial()) {
    on<LoadPartnerDetail>(_loadPartnerById);
    on<UpdatePartnerDetail>(_updatePartnerDetail);
  }

  FutureOr<void> _loadPartnerById(
      LoadPartnerDetail event, Emitter<PartnerDetailState> emit) async {
    try {
      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(event.id)
          .get();

      if (documentSnapshot.exists) {
        final users = documentSnapshot.data() as Map<String, dynamic>;
        emit(PartnerDetailLoaded(UserModel.fromJson(users)));
      } else {
        emit(PartnerDetailNotFound());
      }
    } catch (e) {
      emit(PartnerDetailLoadFailure(e.toString()));
    }
  }
  FutureOr<void> _updatePartnerDetail(
      UpdatePartnerDetail event, Emitter<PartnerDetailState> emit) async {
    try {
      emit(PartnerDetailLoaded(
        event.user,
      ));
    } catch (e) {
      emit(PartnerDetailLoadFailure(e.toString()));
    }
  }
}
