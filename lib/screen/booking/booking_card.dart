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
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          // Avatar Section
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(50),
                //   child: ImageNetworkCacheCommon(
                //     base64: data.partner?.avatar ?? '',
                //     height: 60,
                //     width: 60,
                //   ),
                // ),
                const SizedBox(height: 6),
                Text(
                  data.partner?.name ?? 'Unknown',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // Booking Details Section
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateTimeUtils.convertDateTimeToString(
                      data.time ?? DateTime.now(),
                      format: 'dd/MM/yyyy',
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateTimeUtils.convertDateTimeToString(
                      data.time ?? DateTime.now(),
                      format: 'HH:mm',
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Location: ${data.address ?? 'No Address'}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Add navigation logic or functionality here
                      },
                      child: const Text(
                        'See More',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.calendar_today,
            size: 50,
            color: Colors.grey,
          ),
          const SizedBox(height: 12),
          const Text(
            'No bookings yet!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          OutlineButtonCommon(
            text: 'Book Now',
            onPressed: () {
              // Add navigation to booking page or functionality
            },
          ),
        ],
      ),
    );
  }
}
