import 'package:fitness/common/text_field/text_search_common.dart';
import 'package:fitness/models/user_model.dart';
import 'package:fitness/routing/router_constants.dart';
import 'package:fitness/screen/home_screen/home_tab_bar.dart';
import 'package:fitness/screen/home_screen/partner_card.dart';
import 'package:fitness/screen/users/bloc/users_bloc.dart';
import 'package:fitness/utils/color_utils.dart';
import 'package:fitness/widgets/banner/banner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UsersBloc usersBloc = UsersBloc();
  @override
  void initState() {
    usersBloc.add(const LoadUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => usersBloc,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(child: TextSearchCommon()),
                    Ink(
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            'assets/qr_code.svg',
                            colorFilter: ColorFilter.mode(
                                ColorUtils.fromHex('#808080'), BlendMode.srcIn),
                          ),
                          onPressed: () {
                            context.pushNamed(RouterConstants.qrCode.name);
                          },
                        )),
                  ],
                ),
                const SizedBox(height: 16),
                const BannerView(),
                const SizedBox(height: 16),
                Divider(
                  color: ColorUtils.fromHex('#ECECEC'),
                  height: 1,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: HomeTabBar(
                            titles: const ['Phổ biến', 'Gần bạn'],
                            onTap: (index) {})),
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        'assets/filter.svg',
                        colorFilter: ColorFilter.mode(
                            ColorUtils.fromHex('#303030'), BlendMode.srcIn),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                BlocBuilder<UsersBloc, UsersState>(
                  builder: (context, state) {
                    List<UserModel> users = [];
                    if (state is UsersLoaded) {
                      users = state.users;
                    }
                    return StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: List.generate(
                        users.length,
                        (index) => StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount:
                              (index + 1) % 4 == 2 || (index + 1) % 4 == 3
                                  ? 1.5
                                  : 1.05,
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: PartnerCard(
                              userModel: users[index],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
