import 'package:fitness/common/image_network_cache_common.dart';
import 'package:fitness/routing/router_constants.dart';
import 'package:fitness/screen/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileDetailPage extends StatefulWidget {
  const ProfileDetailPage({super.key});

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          final user = state.user;
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Header
                  _buildProfileHeader(user),
                  const SizedBox(height: 24),
                  // Profile Details Section
                  _buildProfileDetailRow('Tên', user.name ?? 'No Name'),
                  _buildProfileDetailRow(
                      'Email', user.email ?? 'No Email Provided'),
                  _buildProfileDetailRow(
                      'Số điện thoại', user.phone ?? 'Chưa cập nhật'),
                  _buildProfileDetailRow(
                      'Giới tính', user.gender ?? 'Không xác định'),
                  _buildProfileDetailRow(
                      'Ngày sinh', user.bod ?? 'Chưa cập nhật'),

                  const SizedBox(height: 40),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.pushNamed(RouterConstants.profileEdit.name);
                    },
                    icon: const Icon(Icons.login, color: Colors.white),
                    label: const Text(
                      'Chỉnh sửa thông tin',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      textStyle: const TextStyle(fontSize: 18),
                      elevation: 5, // Adding shadow to button
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is AuthenticationLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AuthenticationFailure) {
          return Center(child: Text(state.message)); // Show error message
        }
        return const Center(child: Text('Unknown State'));
      },
    );
  }

  // Profile Header with Avatar and Name
  Widget _buildProfileHeader(user) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: ImageNetworkCacheCommon(
            base64: user.avatar ?? '', // Display avatar or default image
            height: 100, // Set fixed height for the avatar
            width: 100, // Set fixed width for the avatar
            fit: BoxFit.cover, // Ensure image fits within the container
          ),
        ),
        const SizedBox(height: 16),
        Text(
          user.name ?? 'No Name',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          user.id ?? '',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // Profile Detail Row with Label and Value
  Widget _buildProfileDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 100, // Fixed width for label part
            child: Text(
              '$label: ',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
