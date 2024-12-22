part of 'users_bloc.dart';

sealed class UsersState extends Equatable {
  const UsersState();
  
  @override
  List<Object> get props => [];
}

final class UsersInitial extends UsersState {}
final class UsersLoading extends UsersState {}
class UsersLoaded extends UsersState {
  final List<UserModel> users;

  const UsersLoaded(this.users);
    @override
  List<Object> get props => [users];
}

class UsersNotFound extends UsersState {}

class UsersLoadFailure extends UsersState {
  final String error;

  const UsersLoadFailure(this.error);
  @override
  List<Object> get props => [error];
}