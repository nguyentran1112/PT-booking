import 'package:fitness/common/image_network_cache_common.dart';
import 'package:fitness/routing/router_constants.dart';
import 'package:fitness/screen/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:fitness/screen/profile/profile_detail/profile_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        // Handle side-effects like showing a snackbar for errors
        if (state is AuthenticationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          final user = state.user;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ImageNetworkCacheCommon(
                        base64: user.avatar ?? '',
                      )),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    user.name ?? 'No Name',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildOptionsList(),
                _buildLogoutButton(),
              ],
            ),
          );
        }
        // If the state is loading or failure, show a progress indicator or error message
        if (state is AuthenticationLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is AuthenticationFailure) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('Unknown State'));
      },
    );
  }

  // Helper function to build the options list
  Widget _buildOptionsList() {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: ListView(
        shrinkWrap:
            true, // Prevents the ListView from trying to fill the entire screen
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Tiện ích"),
          ),
          ListTile(
            trailing: const Icon(Icons.keyboard_arrow_right_sharp),
            leading: const Icon(Icons.people),
            title: const Text('Thông tin tài khoản'),
            onTap: () {
              context.push(RouterConstants.home.path);
            },
          ),
          const Divider(),
          const ListTile(
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            leading: Icon(Icons.gavel),
            title: Text('Quản lý hợp đồng và dịch vụ'),
          ),
          const Divider(),
          const ListTile(
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            leading: Icon(Icons.history),
            title: Text('Lịch sử tập luyện'),
          ),
          const Divider(),
          const ListTile(
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            leading: Icon(Icons.fitness_center),
            title: Text('Chuyển sang chế độ Coaching'),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Chung"),
          ),
          const ListTile(
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            leading: Icon(Icons.policy),
            title: Text('Điều khoản dịch vụ'),
          ),
          const Divider(),
          const ListTile(
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            leading: Icon(Icons.shield),
            title: Text('Chính sách quyền riêng tư'),
          ),
          const Divider(),
          const ListTile(
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            leading: Icon(Icons.feedback),
            title: Text('Liên hệ và góp ý'),
          ),
          const Divider(),
        ],
      ),
    );
  }

  // Helper function for logout button
  Widget _buildLogoutButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          // Perform the logout action here
          context.read<AuthenticationBloc>().add(Logout());
          context.pushReplacementNamed(RouterConstants.login.name);
        },
        icon: const Icon(Icons.logout),
        label: const Text('Đăng xuất'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          textStyle: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
