import 'package:fitness/common/text_field/text_search_common.dart';
import 'package:fitness/models/search_item_model.dart';
import 'package:fitness/screen/search/bloc/search_bloc.dart';
import 'package:fitness/screen/search/view/item_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchBloc _searchBloc = SearchBloc();
  @override
  void dispose() {
    _searchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => _searchBloc,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
            child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: TextSearchCommon(
                onChanged: (value) {
                  _searchBloc.add(Search(query: value));
                },
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocConsumer<SearchBloc, SearchState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  buildWhen: (previous, current){
                    return current.status != SearchStatus.loadMore;
                  },
                  builder: (context, state) {
                    if (state.status == SearchStatus.initial) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Có thể bạn quan tâm',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            height: 170,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: size.width * 0.35,
                                    height: 150,
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  );
                                }),
                          ),
                          const SizedBox(height: 16),
                          const Text('Khám phá các bộ môn',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: size.width * 0.45,
                                    height: 100,
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      );
                    }
                    if (state.status == SearchStatus.loaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Kết quả tìm kiếm',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(height: 16),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.searchItems.length,
                              itemBuilder: (context, index) {
                                final item = state.searchItems[index];
                                return ItemSearch(item: item);
                              }),
                        ],
                      );
                    }
                    return Skeletonizer(
                      child: ItemSearch(
                        item: SearchItemModel(
                          id: '1',
                          title: 'title                                                            text',
                          image: 'https://picsum.photos/200/300?random=1',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ))
          ],
        )),
      ),
    );
  }
}
