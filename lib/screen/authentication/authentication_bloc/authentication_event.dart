part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppLoad extends AuthenticationEvent {}

class Authenticate extends AuthenticationEvent {
  final UserModel user;

  const Authenticate(this.user);

  @override
  List<Object> get props => [user];
}

class LoginWithGoogle extends AuthenticationEvent {}
class Logout extends AuthenticationEvent {}

class DeleteUser extends AuthenticationEvent {}