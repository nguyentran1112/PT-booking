part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileUpdateFailed extends ProfileState {
  final String error;
  const ProfileUpdateFailed(this.error);
  @override
  List<Object> get props => [error];
}

final class ProfileUpdated extends ProfileState {
  final UserModel user;
  const ProfileUpdated(this.user);
  @override
  List<Object> get props => [user];
}
