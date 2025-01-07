import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/models/banner_model.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc() : super(const BannerState()) {
    on<LoadBanner>(_loadBanner);
  }

  FutureOr<void> _loadBanner(
      LoadBanner event, Emitter<BannerState> emit) async {
    emit(state.copyWith(status: BannerStatus.loading));
    try {
      // final banners = await _bannerRepository.fetchBanners();
      // emit(state.copyWith(banners: banners, status: BannerStatus.loaded));
    } catch (e) {
      emit(state.copyWith(status: BannerStatus.error, message: e.toString()));
    }
  }
}
