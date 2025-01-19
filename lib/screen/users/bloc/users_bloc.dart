import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/models/user_model.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial()) {
    on<LoadUsers>((event, emit) async {
      emit(UsersLoading()); // Emit a loading state
      try {
        final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .get();
  
        if (querySnapshot.docs.isNotEmpty) {
          final users = querySnapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return UserModel.fromJson(data);
          }).toList();
          emit(UsersLoaded(users));
        } else {
          emit(UsersNotFound());
        }
      } catch (e) {
        emit(UsersLoadFailure(e.toString()));
      }
    });
  }
}
