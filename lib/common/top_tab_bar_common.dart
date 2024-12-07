import 'package:flutter/material.dart';

class TopTabBarCommon extends StatefulWidget {
  const TopTabBarCommon({super.key, required this.tabs, required this.onTap});
  final List<String> tabs;
  final ValueChanged<int> onTap;

  @override
  State<TopTabBarCommon> createState() => _TopTabBarCommonState();
}

class _TopTabBarCommonState extends State<TopTabBarCommon> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: widget.tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(controller: _tabController, tabs: widget.tabs.map((e) => Tab(text: e)).toList(), onTap: widget.onTap);
  }
}
