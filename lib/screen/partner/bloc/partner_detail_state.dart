part of 'partner_detail_bloc.dart';

sealed class PartnerDetailState extends Equatable {
  const PartnerDetailState();

  @override
  List<Object> get props => [];
}

final class PartnerDetailInitial extends PartnerDetailState {}

final class PartnerDetailLoading extends PartnerDetailState {}

final class PartnerDetailLoaded extends PartnerDetailState {
  final UserModel partner;

  const PartnerDetailLoaded(this.partner);

  @override
  List<Object> get props => [partner];
}

final class PartnerDetailNotFound extends PartnerDetailState {}

final class PartnerDetailLoadFailure extends PartnerDetailState {
  final String message;

  const PartnerDetailLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}
