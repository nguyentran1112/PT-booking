import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html; // For web file handling
import 'package:fitness/common/custom_outline_border_input.dart';
import 'package:fitness/common/image_network_cache_common.dart';
import 'package:fitness/screen/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:fitness/screen/profile/bloc/profile_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_web/image_picker_web.dart';

import 'package:intl/intl.dart';
import 'package:simple_web_camera/simple_web_camera.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _dateController;
  List<String> genders = ['Nam', 'Nữ', 'Khác'];
  String? selectedItem;

  DateTime? selectedDate = DateTime.now();
  String? avatarBase64;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      _dateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    }
  }

  Future<void> _pickFile() async {
    try {
      Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();

      if (bytesFromPicker != null) {
        avatarBase64 = base64Encode(bytesFromPicker);
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Không có ảnh nào được chọn")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi trong quá trình chọn ảnh: $e')),
      );
    }
  }

  // Start camera stream

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _dateController.dispose();

    super.dispose();
  }

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
          // Set initial values for the text fields
          _nameController.text = user.name ?? '';
          _phoneController.text = user.phone ?? '';
          _dateController.text =
              user.bod ?? DateFormat('dd-MM-yyyy').format(selectedDate!);
          selectedItem = user.gender ?? 'Khác';
          return BlocListener<ProfileBloc, ProfileState>(
            listener: (context, profileState) {
              if (profileState is ProfileUpdated) {
                context
                    .read<AuthenticationBloc>()
                    .add(Authenticate(profileState.user));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Cập nhật thông tin thành công!')),
                );
              } else if (profileState is ProfileUpdateFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(profileState.error)),
                );
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Chỉnh sửa hồ sơ'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Header
                      _buildProfileHeader(user),
                      const SizedBox(height: 24),
                      _buildTextField(_nameController, 'Tên'),
                      const SizedBox(height: 16),
                      _buildTextField(_phoneController, 'Số điện thoại'),
                      const SizedBox(height: 16),
                      _buildGenderDropdown(),
                      const SizedBox(height: 16),
                      _buildDatePickerField(),
                      const SizedBox(height: 40),
                      _buildUpdateButton(context, user),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

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

  Widget _buildProfileHeader(user) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ImageNetworkCacheCommon(
                base64: avatarBase64 ?? user.avatar ?? '',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 200,
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Center(
                              child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  var res = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SimpleWebCameraPage(
                                              appBarTitle: "Take a Picture",
                                              centerTitle: true),
                                    ),
                                  );
                                  setState(() {
                                    if (res is String) {
                                      avatarBase64 = res;
                                    }
                                  });
                                },
                                child: const Text("Take a picture"),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              ElevatedButton(
                                  onPressed: _pickFile,
                                  child: const Text("Chọn ảnh từ thư viện")),
                            ],
                          )),
                        ),
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white.withOpacity(0.7),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
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
          user.email ?? 'No Email Provided',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // Reusable TextField Widget
  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16.0),
        labelText: label,
        border: const CustomOutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }

  // Gender Dropdown
  Widget _buildGenderDropdown() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        value: selectedItem,
        onChanged: (String? newValue) {
          selectedItem = newValue;
        },
        isExpanded: true,
        underline: Container(),
        items: genders.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(value),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Date Picker Field
  Widget _buildDatePickerField() {
    return TextField(
      onTap: () {
        _selectDate(context);
      },
      readOnly: true,
      controller: _dateController,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(16.0),
        labelText: 'Ngày sinh',
        border: CustomOutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }

  // Update Button
  Widget _buildUpdateButton(BuildContext context, user) {
    return ElevatedButton.icon(
      onPressed: () {
        final updatedName = _nameController.text;
        final updateBOD = _dateController.text;
        final updatePhone = _phoneController.text;

        // Dispatch UpdateProfile event to ProfileBloc
        context.read<ProfileBloc>().add(UpdateProfile(
              request: user.copyWith(
                  avatar: avatarBase64,
                  phone: updatePhone,
                  bod: updateBOD,
                  name: updatedName,
                  gender: selectedItem),
            ));
      },
      icon: const Icon(Icons.save, color: Colors.white),
      label: const Text(
        'Cập nhật thông tin',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrangeAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        textStyle: const TextStyle(fontSize: 18),
        elevation: 5,
      ),
    );
  }
}
