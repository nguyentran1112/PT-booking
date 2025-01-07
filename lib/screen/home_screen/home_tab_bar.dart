import 'package:fitness/utils/color_utils.dart';
import 'package:flutter/material.dart';

class HomeTabBar extends StatefulWidget {
  const HomeTabBar({super.key, required this.titles, required this.onTap});
  final List<String> titles;
  final ValueChanged<int> onTap;
  @override
  State<HomeTabBar> createState() => _HomeTabBarState();
}

class _HomeTabBarState extends State<HomeTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: widget.titles.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      indicatorColor: ColorUtils.fromHex('#FA6400'),
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      dividerColor: Colors.transparent,
      tabAlignment: TabAlignment.start,
      tabs: widget.titles
          .map((e) => Tab(
                child: Text(
                  e,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ))
          .toList(),
      onTap: widget.onTap,
    );
  }
}
