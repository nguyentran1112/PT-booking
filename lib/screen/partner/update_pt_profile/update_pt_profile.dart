import 'package:flutter/material.dart';

class UpdatePtProfile extends StatefulWidget {
  const UpdatePtProfile({super.key, required this.userId});
  final String userId;
  @override
  State<UpdatePtProfile> createState() => _UpdatePtProfileState();
}

class _UpdatePtProfileState extends State<UpdatePtProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cập nhật thông tin PT'),
      ),
      body: const Placeholder(),
    );
  }
}
