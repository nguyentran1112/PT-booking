// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'update_pt_profile_bloc.dart';

enum UpdatePtProfileStatus { initial, loading, success, error }

class UpdatePtProfileState extends Equatable {
  const UpdatePtProfileState({
    this.status = UpdatePtProfileStatus.initial,
    this.message = '',
    this.user,
  });
  final UpdatePtProfileStatus status;
  final String message;
  final UserModel? user;
  @override
  List<Object?> get props => [
        status,
        message,
        user,
      ];

  UpdatePtProfileState copyWith({
    UpdatePtProfileStatus? status,
    String? message,
    UserModel? user,
  }) {
    return UpdatePtProfileState(
      status: status ?? this.status,
      message: message ?? this.message,
      user: user ?? this.user,
    );
  }
}
