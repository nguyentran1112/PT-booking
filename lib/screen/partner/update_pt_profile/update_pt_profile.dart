import 'dart:convert';

import 'package:fitness/common/image_network_cache_common.dart';
import 'package:fitness/common/loading_dialog.dart';
import 'package:fitness/common/text_field/text_form_field_common.dart';
import 'package:fitness/constants/social_enum.dart';
import 'package:fitness/models/schedule_model.dart';
import 'package:fitness/models/social_model.dart';
import 'package:fitness/models/user_model.dart';
import 'package:fitness/screen/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:fitness/screen/partner/update_pt_profile/bloc/update_pt_profile_bloc.dart';
import 'package:fitness/screen/type_of_gym_cubit/type_of_gym_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_range_picker/time_range_picker.dart';

class UpdatePtProfile extends StatefulWidget {
  const UpdatePtProfile({super.key, required this.userId});
  final String userId;
  @override
  State<UpdatePtProfile> createState() => _UpdatePtProfileState();
}

class _UpdatePtProfileState extends State<UpdatePtProfile> {
  final UpdatePtProfileBloc _bloc = UpdatePtProfileBloc();
  UserModel? _user;
  @override
  void initState() {
    _bloc.add(LoadProfile(widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Cập nhật thông tin PT'),
        ),
        body: BlocConsumer<UpdatePtProfileBloc, UpdatePtProfileState>(
          listener: (context, state) {
            if (state.status != UpdatePtProfileStatus.updating) {
              LoadingDialog.enableScreen(context);
            }
            if (state.status == UpdatePtProfileStatus.loaded) {
              _user = state.user;
            }
            if (state.status == UpdatePtProfileStatus.success) {
              context.pop(state.user);
              context.read<AuthenticationBloc>().add(Authenticate(state.user!));
            }
          },
          builder: (context, state) {
            if (state.status == UpdatePtProfileStatus.loading ||
                _user == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildImagePicker(),
                      const SizedBox(height: 20),
                      TextFormFieldCommon(
                        labelText: 'Họ và tên',
                        initialValue: _user?.name,
                        onChanged: (value) {
                          _user!.name = value;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormFieldCommon(
                        labelText: 'Email',
                        initialValue: _user?.email,
                        onChanged: (value) {
                          _user!.email = value;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormFieldCommon(
                        labelText: 'Số điện thoại',
                        initialValue: _user?.phone,
                        onChanged: (value) {
                          _user!.phone = value;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormFieldCommon(
                        labelText: 'Địa chỉ',
                        initialValue: _user?.address,
                        onChanged: (value) {
                          _user!.address = value;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormFieldCommon(
                        labelText: 'Kinh nghiệm',
                        initialValue: (_user?.experience ?? 0).toString(),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        onChanged: (value) {
                          _user!.experience = double.tryParse(value) ?? 0;
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text('Giới thiệu'),
                      TextFormFieldCommon(
                        initialValue: _user?.description,
                        labelText: 'Giới thiệu',
                        maxLines: 5,
                        onChanged: (value) {
                          _user!.description = value;
                        },
                      ),
                      const SizedBox(height: 10),
                      _buildSocials(),
                      const SizedBox(height: 10),
                      _buildSchedule(),
                      const SizedBox(height: 10),
                      const Text('Loại tập luyện'),
                      const SizedBox(height: 10),
                      _buildTypeOfGym(),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          LoadingDialog.disableScreen(context);
                          _bloc.add(UpdateProfile(_user!));
                        },
                        child: const Text('Cập nhật'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    if (_user?.avatar != null) {
      return InkWell(
        onTap: () {
          _showImagePicker();
        },
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1),
          ),
          child: ImageNetworkCacheCommon(base64: _user!.avatar!),
        ),
      );
    }
    return InkWell(
      onTap: () {
        _showImagePicker();
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(width: 1),
        ),
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  _showImagePicker() async {
    try {
      final ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final base64 = await image.readAsBytes();
        setState(() {
          _user!.avatar = base64Encode(base64);
        });
      }
    } catch (_) {}
  }

  Widget _buildSocials() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _user?.socials?.length ?? 0,
          itemBuilder: (context, index) {
            final social = _user!.socials![index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: SocialEnum.values.map((e) {
                                return ListTile(
                                  title: Text(e.name),
                                  onTap: () {
                                    Navigator.pop(context, e);
                                  },
                                );
                              }).toList(),
                            );
                          }).then((value) {
                        if (value != null) {
                          setState(() {
                            social.type = value;
                          });
                        }
                      });
                    },
                    child: SvgPicture.asset(
                      social.type?.icon ?? '',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormFieldCommon(
                      labelText: 'Link',
                      initialValue: social.url,
                      onChanged: (value) {
                        social.url = value;
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    _user!.socials ??= [];
                    _user!.socials!
                        .add(SocialModel(type: SocialEnum.unknown, url: ''));
                    setState(() {});
                  },
                  child: const Text('Thêm mạng xã hội')),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                _user!.socials!.removeLast();
                setState(() {});
              },
              child: const Text('Xóa'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _user?.schedules?.length ?? 0,
          itemBuilder: (context, index) {
            final schedule = _user!.schedules![index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: ScheduleEnum.values.map((e) {
                                return ListTile(
                                  title: Text(translateDayOfWeek(e)),
                                  onTap: () {
                                    Navigator.pop(context, e);
                                  },
                                );
                              }).toList(),
                            );
                          }).then((value) {
                        if (value != null) {
                          setState(() {
                            schedule.dayOfWeek = value;
                          });
                        }
                      });
                    },
                    child: Text(translateDayOfWeek(schedule.dayOfWeek)),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: [
                        ...schedule.timeRangers.map((e) {
                          return InkWell(
                            onTap: () async {
                              TimeRange result = await showTimeRangePicker(
                                context: context,
                                fromText: 'Từ',
                                toText: 'Đến',
                                start: e.start,
                                end: e.end,
                                strokeColor: Colors.blue,
                                ticksColor: Colors.blue,
                                selectedColor: Colors.blue,
                                handlerColor: Colors.blue,
                                labels: [
                                  "12 am",
                                  "3 am",
                                  "6 am",
                                  "9 am",
                                  "12 pm",
                                  "3 pm",
                                  "6 pm",
                                  "9 pm"
                                ].asMap().entries.map((e) {
                                  return ClockLabel.fromIndex(
                                      idx: e.key, length: 8, text: e.value);
                                }).toList(),
                                labelOffset: 35,
                                rotateLabels: false,
                                padding: 60,
                                strokeWidth: 8,
                              );
                              setState(() {
                                e.start = result.startTime;
                                e.end = result.endTime;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                  '${e.start.format(context)} - ${e.end.format(context)}'),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      if (schedule.timeRangers.length >= 5) {
                        schedule.timeRangers.removeLast();
                        setState(() {});
                        return;
                      }
                      schedule.timeRangers.add(TimeRanger(
                          start: const TimeOfDay(hour: 0, minute: 0),
                          end: const TimeOfDay(hour: 0, minute: 0)));
                      setState(() {});
                    },
                    alignment: Alignment.center,
                    icon: Icon(schedule.timeRangers.length >= 3
                        ? Icons.remove
                        : Icons.add),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    _user!.schedules ??= [];
                    _user!.schedules!.add(ScheduleModel(
                        dayOfWeek: ScheduleEnum.monday, timeRangers: []));
                    setState(() {});
                  },
                  child: const Text('Thêm lịch tập')),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                _user!.schedules!.removeLast();
                setState(() {});
              },
              child: const Text('Xóa'),
            ),
          ],
        ),
      ],
    );
  }

  String translateDayOfWeek(ScheduleEnum dayOfWeek) {
    switch (dayOfWeek) {
      case ScheduleEnum.monday:
        return 'Thứ 2';
      case ScheduleEnum.tuesday:
        return 'Thứ 3';
      case ScheduleEnum.wednesday:
        return 'Thứ 4';
      case ScheduleEnum.thursday:
        return 'Thứ 5';
      case ScheduleEnum.friday:
        return 'Thứ 6';
      case ScheduleEnum.saturday:
        return 'Thứ 7';
      case ScheduleEnum.sunday:
        return 'Chủ nhật';
      default:
        return 'Không xác định';
    }
  }

  Widget _buildTypeOfGym() {
    return BlocBuilder<TypeOfGymCubit, TypeOfGymState>(
      builder: (context, state) {
        if (state.status == TypeOfGymStatus.success) {
          return Wrap(
            spacing: 4,
            runSpacing: 4,
            children: state.typeOfGym.map((e) {
              return InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  _user!.categories ??= [];
                  if (_user!.categories!.contains(e)) {
                    _user!.categories!.remove(e);
                  } else {
                    _user!.categories!.add(e);
                  }
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _user!.categories?.contains(e) == true
                          ? Colors.blue
                          : Colors.black26,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(e),
                ),
              );
            }).toList(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
