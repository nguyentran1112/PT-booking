import 'package:fitness/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomBarIcon extends StatefulWidget {
  const BottomBarIcon({super.key, required this.icons, this.onTap});
  final List<String> icons;
  final ValueChanged<int>? onTap;
  @override
  State<BottomBarIcon> createState() => _BottomBarIconState();
}

class _BottomBarIconState extends State<BottomBarIcon>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  @override
  void initState() {
    _tabController = TabController(length: widget.icons.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: (value) {
        setState(() {
          _currentIndex = value;
        });
        widget.onTap?.call(value);
      },
      tabs: List.generate(
        widget.icons.length,
        (index) => Tab(
          icon: SvgPicture.asset(
            widget.icons[index],
            colorFilter: ColorFilter.mode(
                index == _currentIndex
                    ? ColorUtils.fromHex('#FA6400')
                    : ColorUtils.fromHex('#303030'),
                BlendMode.srcIn),
          ),
        ),
      ),
      controller: _tabController,
      indicatorColor: ColorUtils.fromHex('#FA6400'),
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }
}
