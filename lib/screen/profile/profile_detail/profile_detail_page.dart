import 'package:flutter/material.dart';

class ProfileDetailPage extends StatefulWidget {
  const ProfileDetailPage({super.key});

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileDetailPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProfileDetailPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
