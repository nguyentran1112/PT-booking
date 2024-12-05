part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

final class Search extends SearchEvent {
  final String query;
  const Search({
    required this.query,
  });
  @override
  List<Object> get props => [query,];
}

final class LoadMore extends SearchEvent {
  const LoadMore();
}