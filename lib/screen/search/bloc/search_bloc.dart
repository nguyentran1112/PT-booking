import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/models/search_item_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<Search>(_search, transformer: restartable());
  }
  FutureOr<void> _search(Search event, Emitter<SearchState> emit) async {
    emit(state.copyWith(status: SearchStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (event.query.isEmpty) {
        emit(state.copyWith(
            status: SearchStatus.initial,
            searchItems: [],
            query: event.query,
            page: 0,
            hasMore: true));
        return;
      }
      emit(state.copyWith(
        status: SearchStatus.loaded,
        searchItems: mock,
        query: event.query,
        page: 1,
        hasMore: true,
      ));
    } catch (e) {
      emit(state.copyWith(status: SearchStatus.failure, message: e.toString()));
    }
  }
}

List<SearchItemModel> mock = [
  SearchItemModel(
    id: '1',
    title: 'Nguyễn Văn A' ,
    image: 'https://picsum.photos/200/300?random=1',
    category: 'Gym',
    rating: 4.5,
  ),
  SearchItemModel(
    id: '2',
    title: 'Nguyễn Văn B',
    image: 'https://picsum.photos/200/300?random=2',
    category: 'Gym',
    rating: 4.5,
  ),
  SearchItemModel(
    id: '3',
    title: 'Nguyễn Văn C',
    image: 'https://picsum.photos/200/300?random=3',
    category: 'Gym',
    rating: 4.5,
  ),
  SearchItemModel(
    id: '4',
    title: 'Nguyễn Văn D',
    image: 'https://picsum.photos/200/300?random=4',
    category: 'Gym',
    rating: 4.5,
  ),
  SearchItemModel(
    id: '5',
    title: 'Nguyễn Văn E',
    image: 'https://picsum.photos/200/300?random=5',
    category: 'Gym',
    rating: 4.5,
  ),
  SearchItemModel(
    id: '6',
    title: 'Nguyễn Văn F',
    image: 'https://picsum.photos/200/300?random=6',
    category: 'Gym',
    rating: 4.5,
  ),
  SearchItemModel(
    id: '7',
    title: 'Nguyễn Văn G',
    image: 'https://picsum.photos/200/300?random=7',
    category: 'Gym',
    rating: 4.5,
  ),
  SearchItemModel(
    id: '8',
    title: 'Nguyễn Văn H',
    image: 'https://picsum.photos/200/300?random=8',
    category: 'Gym',
    rating: 4.5,
  ),
  SearchItemModel(
    id: '9',
    title: 'Nguyễn Văn I',
    image: 'https://picsum.photos/200/300?random=9',
    category: 'Gym',
    rating: 4.5,
  ),
  
];
