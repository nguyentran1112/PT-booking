import 'package:fitness/common/buttons/outline_button_common.dart';
import 'package:fitness/models/fit_category.dart';
import 'package:fitness/models/user_model.dart';
import 'package:fitness/routing/router_constants.dart';
import 'package:fitness/screen/users/bloc/users_bloc.dart';
import 'package:fitness/widgets/hlv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserModel> users = [];

  @override
  void initState() {
    context.read<UsersBloc>().add(const LoadUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<UsersBloc, UsersState>(
      listener: (context, state) {
        if (state is UsersLoaded) {
          users = state.users;
          setState(() {});
        }
      },
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
                    Center(
                        child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.pinkAccent,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.qr_code),
                        color: Colors.white,
                        onPressed: () {
                          context.pushNamed(RouterConstants.qrCode.name);
                        },
                      ),
                    )),
                    Center(
                        child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.pinkAccent,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.notifications_none),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    )),
                  ],
                ),
                const SizedBox(height: 16),
                OutlineButtonCommon(
                  text: 'Tất cả',
                  onPressed: () {},
                  textStyle: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
                  style: OutlinedButton.styleFrom(
                    // border radius
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: List<Widget>.generate(
                    3,
                    (int index) => SizedBox(
                      width: size.width / 2 - 16 - 8,
                      height: 100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 70,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const Expanded(
                              child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Giảm mỡ'),
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Nổi bật',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GridView.builder(
                    itemCount: fitCategories.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 2.5 / 1, crossAxisSpacing: 4, mainAxisSpacing: 4),
                    itemBuilder: (context, index) {
                      return OutlineButtonCommon(
                          text: fitCategories[index].name,
                          onPressed: () {},
                          textStyle: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )));
                    }),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Huấn luyện viên gần bạn',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )),
                    InkWell(
                      onTap: () {},
                      child: const Text('Xem thêm',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 170,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: HlvCard(
                            name: users[index].name ?? '',
                            id: users[index].id ?? '',
                            avatar: users[index].avatar ?? '',
                            category: 'Gym',
                          ),
                        );
                      }),
                ),
                const SizedBox(height: 16),
                const Text('Huấn luyện viên Nổi bật',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 170,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: HlvCard(
                            name: 'Nguyễn Văn A',
                            id: '1',
                            avatar: 'https://i.ytimg.com/vi/QQRAZrz0Bkw/maxresdefault.jpg',
                            category: 'Gym',
                          ),
                        );
                      }),
                ),
                const Text('Có thể bạn quan tâm',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 170,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          width: size.width * 0.7,
                          height: 150,
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
