import 'package:fitness/common/buttons/outline_button_common.dart';
import 'package:fitness/common/image_network_cache_common.dart';
import 'package:fitness/models/booking_model.dart';
import 'package:fitness/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({super.key, required this.data});
  final BookingModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRect(child: ImageNetworkCacheCommon(base64: data.partner?.avatar ?? '')),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  data.partner?.name ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateTimeUtils.convertDateTimeToString(data.time ?? DateTime.now(), format: 'dd/MM/yyyy'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateTimeUtils.convertDateTimeToString(data.time ?? DateTime.now(), format: 'HH:mm'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'tại: ${data.address ?? ''}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('xem thêm'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookingEmpty extends StatelessWidget {
  const BookingEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          const Text(
            'Bạn chưa có buổi tập nào được đặt!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          OutlineButtonCommon(
            text: 'Đặt ngay',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
