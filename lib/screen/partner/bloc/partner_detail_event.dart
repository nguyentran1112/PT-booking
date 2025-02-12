part of 'partner_detail_bloc.dart';

sealed class PartnerDetailEvent extends Equatable {
  const PartnerDetailEvent();

  @override
  List<Object> get props => [];
}

final class LoadPartnerDetail extends PartnerDetailEvent {
  final String id;

  const LoadPartnerDetail(this.id);

  @override
  List<Object> get props => [id];
}

final class UpdatePartnerDetail extends PartnerDetailEvent {
  final UserModel user;

  const UpdatePartnerDetail(this.user);

  @override
  List<Object> get props => [user];
}
