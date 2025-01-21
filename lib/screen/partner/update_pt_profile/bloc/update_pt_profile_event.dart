part of 'update_pt_profile_bloc.dart';

sealed class UpdatePtProfileEvent extends Equatable {
  const UpdatePtProfileEvent();

  @override
  List<Object> get props => [];
}

final class LoadProfile extends UpdatePtProfileEvent {
  final String id;
  const LoadProfile(this.id);
}

final class UpdateProfile extends UpdatePtProfileEvent {
  final UserModel user;
  const UpdateProfile(this.user);
}
