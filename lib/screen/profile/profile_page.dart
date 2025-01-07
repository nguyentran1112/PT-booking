import 'package:fitness/routing/router_constants.dart';
import 'package:fitness/screen/authentication/authentication_bloc/authentication_bloc.dart';
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
        // Listen for changes and handle side-effects
        if (state is AuthenticationFailure) {
          // Example: Show a snack bar or handle error states
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        // If state is AuthenticationSuccess, display user profile
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
                    child: Image.network(
                      user.avatar ??
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnsGyZ2ZCY9gW6vpC4nrCcBuHHqmqy7rAUKg&s',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey.shade300,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image_rounded,
                              size: 40, color: Colors.pink),
                        );
                      },
                    ),
                  ),
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
                _buildSectionTitle('Tiện ích'),
                _buildOptionsList(),
                const SizedBox(height: 16),
                _buildSectionTitle('Chung'),
                _buildPrivacyList(),
                const SizedBox(height: 16),
                _buildLogoutButton(),
              ],
            ),
          );
        }
        // In case of loading or other states, show a loading spinner
        else if (state is AuthenticationLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthenticationFailure) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('Unknown State'));
      },
    );
  }

  // Helper function to build the title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(title),
    );
  }

  // Helper function to build the options list
  Widget _buildOptionsList() {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      height: 200, // Adjust height as per your need
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: const <Widget>[
          ListTile(
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            leading: Icon(Icons.gavel),
            title: Text('Quản lý hợp đồng và dịch vụ'),
          ),
          Divider(),
          ListTile(
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            leading: Icon(Icons.history),
            title: Text('Lịch sử tập luyện'),
          ),
          Divider(),
          ListTile(
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            leading: Icon(Icons.fitness_center),
            title: Text('Chuyển sang chế độ Coaching'),
          ),
          Divider(),
        ],
      ),
    );
  }

  // Helper function to build the privacy list
  Widget _buildPrivacyList() {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      height: 200, // Adjust height as per your need
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: const <Widget>[
          ListTile(
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            leading: Icon(Icons.policy),
            title: Text('Điều khoản dịch vụ'),
          ),
          Divider(),
          ListTile(
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            leading: Icon(Icons.shield),
            title: Text('Chính sách quyền riêng tư'),
          ),
          Divider(),
          ListTile(
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            leading: Icon(Icons.feedback),
            title: Text('Liên hệ và góp ý'),
          ),
          Divider(),
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
