part of 'search_bloc.dart';

enum SearchStatus { initial, loading, loaded, failure, loadMore }
class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.message = '',
    this.searchItems = const <SearchItemModel>[],
    this.hasMore = true,
    this.page = 1,
    this.query = '',
    this.pageSize = 10,
  });
  final SearchStatus status;
  final String message;
  final List<SearchItemModel> searchItems;
  final bool hasMore;
  final int page;
  final String query;
  final int pageSize;
  @override
  List<Object> get props => [
        status,
        message,
        searchItems,
        hasMore,
        page,
        query,
        pageSize,
  ];
  SearchState copyWith({
    SearchStatus? status,
    String? message,
    List<SearchItemModel>? searchItems,
    bool? hasMore,
    int? page,
    String? query,
    int? pageSize,
  }) {
    return SearchState(
      status: status ?? this.status,
      message: message ?? this.message,
      searchItems: searchItems ?? this.searchItems,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
      query: query ?? this.query,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

