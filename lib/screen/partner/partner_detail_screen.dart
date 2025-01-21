import 'package:fitness/common/image_network_cache_common.dart';
import 'package:fitness/constants/social_enum.dart';
import 'package:fitness/models/schedule_model.dart';
import 'package:fitness/models/user_model.dart';
import 'package:fitness/routing/router_constants.dart';
import 'package:fitness/screen/feedback/feedback_dialog.dart';
import 'package:fitness/screen/partner/bloc/partner_detail_bloc.dart';
import 'package:fitness/utils/color_utils.dart';
import 'package:fitness/utils/js_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class PartnerDetailScreen extends StatefulWidget {
  const PartnerDetailScreen({super.key, required this.id});
  final String id;
  @override
  State<PartnerDetailScreen> createState() => _PartnerDetailScreenState();
}

class _PartnerDetailScreenState extends State<PartnerDetailScreen> {
  late PartnerDetailBloc _partnerDetailBloc;
  @override
  void initState() {
    _partnerDetailBloc = PartnerDetailBloc();
    _partnerDetailBloc.add(LoadPartnerDetail(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => _partnerDetailBloc,
        child: BlocBuilder<PartnerDetailBloc, PartnerDetailState>(
          builder: (context, state) {
            if (state is PartnerDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PartnerDetailLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.partner.name ?? ''),
                    Row(
                      children: [
                        Text((state.partner.rating ?? 0).toStringAsFixed(1)),
                        RatingBarIndicator(
                          itemSize: 12,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          rating: state.partner.rating ?? 0,
                        ),
                        Text('(${state.partner.totalRating ?? 0})'),
                      ],
                    ),
                    Text(state.partner.email ?? ''),
                    Text(
                        'Kinh nghiệp huấn luyện: ${state.partner.experience} năm'),
                    SizedBox(
                      height: 6,
                    ),
                    Wrap(
                      spacing: 3.0, // gap between adjacent chips
                      children: (state.partner.categories ?? []).map((e) {
                        return Chip(
                          label: Text(e),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: Colors.white,
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          side: BorderSide(
                            color: ColorUtils.fromHex('#FA6400'),
                            width: 1, // Border width
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: ClipRect(
                          child: ImageNetworkCacheCommon(
                              base64: state.partner.avatar ?? '',
                              fit: BoxFit.cover),
                        )),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Giới thiệu'),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return FeedbackDialog(
                                  user: state.partner,
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Đánh giá',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            context.pushNamed(
                                RouterConstants.profilePTEdit.name,
                                pathParameters: {
                                  'id': widget.id
                                }).then((value) {
                              if (value != null &&
                                  mounted &&
                                  value is UserModel) {
                                context
                                    .read<PartnerDetailBloc>()
                                    .add(UpdatePartnerDetail(value));
                              }
                            });
                          },
                          child: const Text(
                            'update',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                      width: double.infinity,
                      child: Text(state.partner.description ?? ''),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text('Địa điểm: '),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          state.partner.address ?? '',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        const Text('Số điện thoại: '),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          state.partner.phone ?? '',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.partner.socials?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            SvgPicture.asset(
                              state.partner.socials?[index].type?.icon ?? '',
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            GestureDetector(
                                onTap: () {
                                  JsUtils.openUrl(
                                      state.partner.socials?[index].url ?? '');
                                },
                                child: Text(
                                  state.partner.socials?[index].url ?? '',
                                  style: const TextStyle(color: Colors.blue),
                                )),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ListView.builder(
                      itemCount: state.partner.schedules?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(translateDayOfWeek(
                                state.partner.schedules?[index].dayOfWeek ??
                                    ScheduleEnum.monday)),
                            const SizedBox(
                              width: 12,
                            ),
                            Wrap(
                              spacing: 3.0, // gap between adjacent chips
                              runSpacing: 3.0,
                              children: state
                                      .partner.schedules?[index].timeRangers
                                      .map((e) {
                                    return Chip(
                                      label: Text(
                                          '${e.start.format(context)} - ${e.end.format(context)}'),
                                      backgroundColor: Colors.white,
                                      labelStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      side: BorderSide(
                                        color: ColorUtils.fromHex('#FA6400'),
                                        width: 1, // Border width
                                      ),
                                    );
                                  }).toList() ??
                                  [],
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
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
}

