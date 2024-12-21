part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();
  
  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationSuccess extends AuthenticationState {
  final UserModel user;
  
  const AuthenticationSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class AuthenticationFailure extends AuthenticationState {
  final String message;

  const AuthenticationFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class AuthenticationLoading extends AuthenticationState {}

final class Unauthenticated extends AuthenticationState {}