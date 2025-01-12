import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(Unauthenticated()) {
    on<Authenticate>(_authenticate);
    on<AppLoad>(_appLoad);
    on<Logout>(_logout);
    on<DeleteUser>(_deleteUser);
    on<LoginWithGoogle>(_loginWithGoogle);
  }
  FutureOr<void> _loginWithGoogle(
      LoginWithGoogle event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
              clientId:
                  '470282686755-613pc70bgt8v6qcqa9t504uqms2l0ei6.apps.googleusercontent.com')
          .signIn();
      if (googleUser == null) {
        emit(const AuthenticationFailure('Google Sign In Failed'));
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final String email = userCredential.user?.email ?? '';
      final String uid = userCredential.user?.uid ?? '';
      final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);
      final userSnapshot = await userDoc.get();
      String? base64Image;
      if (!userSnapshot.exists) {
        if (userCredential.user?.photoURL != null) {
          try {
            final response =
                await http.get(Uri.parse(userCredential.user!.photoURL!));
            if (response.statusCode == 200) {
              base64Image = base64Encode(response.bodyBytes);
            } else {
              print('Failed to download image');
            }
          } catch (e) {
            print('Error downloading or converting image: $e');
          }
        }
        await userDoc.set({
          'email': email,
          'name': userCredential.user?.displayName ?? '',
          'avatar': base64Image ?? '',
          'id': uid,
        });
      }
      final userData = await userDoc.get();
      UserModel user = UserModel.fromJson(userData.data()!);

// Emit success state with the user model
      emit(AuthenticationSuccess(user));
    } catch (e) {
      print(e.toString());
      emit(const AuthenticationFailure('Google Sign In Failed'));
    }
  }

  FutureOr<void> _authenticate(
      Authenticate event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    emit(AuthenticationSuccess(event.user));
  }

  FutureOr<void> _appLoad(
      AppLoad event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final String uid = user.uid;
      final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);
      final userSnapshot = await userDoc.get();
      if (userSnapshot.exists) {
        final user = UserModel.fromJson(userSnapshot.data()!);
        emit(AuthenticationSuccess(user));
      } else {
        emit(Unauthenticated());
      }
    } else {
      emit(Unauthenticated());
    }
  }

  FutureOr<void> _logout(
      Logout event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
    } catch (_) {
    } finally {
      emit(Unauthenticated());
    }
  }

  FutureOr<void> _deleteUser(
      DeleteUser event, Emitter<AuthenticationState> emit) async {
    late UserModel userModel;
    if (state is AuthenticationSuccess) {
      userModel = (state as AuthenticationSuccess).user;
    }
    emit(AuthenticationLoading());
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(userModel.id);
      await userDoc.delete();
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      emit(Unauthenticated());
    }
  }
}
