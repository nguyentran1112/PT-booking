import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fitness/common/image_network_cache_common.dart';
import 'package:fitness/constants/social_enum.dart';
import 'package:fitness/models/schedule_model.dart';
import 'package:fitness/screen/partner/bloc/partner_detail_bloc.dart';
import 'package:fitness/utils/js_utils.dart';

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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Chi tiết đối tác'),
        backgroundColor: Colors.orange.shade700,
      ),
      body: BlocProvider(
        create: (_) => _partnerDetailBloc,
        child: BlocBuilder<PartnerDetailBloc, PartnerDetailState>(
          builder: (context, state) {
            if (state is PartnerDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PartnerDetailLoaded) {
              final partner = state.partner;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Partner Avatar and Name
                    Center(
                      child: Column(
                        children: [
                          ImageNetworkCacheCommon(base64: partner.avatar ?? ''),
                          const SizedBox(height: 16),
                          Text(
                            partner.name ?? 'Không có tên',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBarIndicator(
                          rating: partner.rating ?? 0,
                          itemCount: 5,
                          itemSize: 20,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${partner.totalRating ?? 0})',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Partner Information
                    _infoRow(
                      title: 'Email:',
                      value: partner.email ?? 'Không có email',
                    ),
                    _infoRow(
                      title: 'Kinh nghiệm:',
                      value: '${partner.experience} năm',
                    ),

                    const SizedBox(height: 16),

                    // Specializations
                    const Text(
                      'Chuyên môn:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      children: partner.categories?.map((e) {
                            return Chip(
                              label: Text(e),
                              backgroundColor: Colors.orange.shade100,
                            );
                          }).toList() ??
                          [],
                    ),

                    const SizedBox(height: 24),

                    // Description
                    const Text(
                      'Giới thiệu:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Text(
                        partner.description ?? 'Không có mô tả.',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Address and Phone
                    _infoRow(
                      title: 'Địa điểm:',
                      value: partner.address ?? 'Không xác định',
                    ),
                    _infoRow(
                      title: 'Số điện thoại:',
                      value: partner.phone ?? 'Không xác định',
                    ),

                    const SizedBox(height: 24),

                    // Social Links
                    const Text(
                      'Liên kết xã hội:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...?partner.socials?.map((social) => ListTile(
                          leading: SvgPicture.asset(
                            social.type?.icon ?? '',
                            width: 24,
                            height: 24,
                          ),
                          title: Text(
                            social.url ?? '',
                            style: const TextStyle(color: Colors.blue),
                          ),
                          onTap: () => JsUtils.openUrl(social.url ?? ''),
                        )),

                    const SizedBox(height: 24),

                    // Schedules
                    const Text(
                      'Lịch làm việc:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...?partner.schedules?.map((schedule) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Text(
                                translateDayOfWeek(schedule.dayOfWeek),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Wrap(
                                spacing: 8,
                                children: schedule.timeRangers.map((timeRange) {
                                  return Chip(
                                    label: Text(
                                        '${timeRange.start.format(context)} - ${timeRange.end.format(context)}'),
                                    backgroundColor: Colors.orange.shade100,
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        )),
                    Center(child: OutlinedButton(onPressed: () {}, child: Text("Booking")))
                  ],
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _infoRow({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
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

      case ScheduleEnum.unknown:
        return 'Chủ nhật';
    }
  }
}
