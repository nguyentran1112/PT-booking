import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Mock list of notifications
  final List<Map<String, String>> _notifications = [
    {
      'title': 'New Class Available',
      'description': 'A new yoga class has been added. Join now!',
      'time': '2 hours ago',
    },
    {
      'title': 'Membership Renewal',
      'description': 'Your membership is about to expire. Renew it today!',
      'time': '1 day ago',
    },
    {
      'title': 'Special Discount',
      'description': 'Get 20% off on all classes this weekend!',
      'time': '3 days ago',
    },
    {
      'title': 'New Message',
      'description': 'You have received a message from your trainer.',
      'time': '1 week ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Thông báo',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert_outlined),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: _notifications.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final notification = _notifications[index];
                  return ListTile(
                    title: Text(
                      notification['title']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notification['description']!),
                        const SizedBox(height: 4),
                        Text(
                          notification['time']!,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
