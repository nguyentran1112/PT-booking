part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}
final class UpdateProfile extends ProfileEvent {
  final UserModel request;
  const UpdateProfile({required this.request,});
  
  @override
  List<Object> get props => [request];
}