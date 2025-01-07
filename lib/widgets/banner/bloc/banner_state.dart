part of 'banner_bloc.dart';

enum BannerStatus { initial, loading, loaded, error }

class BannerState extends Equatable {
  const BannerState({
    this.banners = const <BannerModel>[],
    this.status = BannerStatus.initial,
    this.message = '',
  });
  final BannerStatus status;
  final List<BannerModel> banners;
  final String message;
  @override
  List<Object> get props => [
        banners,
        status,
        message,
      ];

  BannerState copyWith({
    List<BannerModel>? banners,
    BannerStatus? status,
    String? message,
  }) {
    return BannerState(
      banners: banners ?? this.banners,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
