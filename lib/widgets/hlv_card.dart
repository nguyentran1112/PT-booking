import 'package:flutter/material.dart';

class HlvCard extends StatelessWidget {
  const HlvCard(
      {super.key,
      required this.name,
      required this.id,
      this.avatar,
      this.category});
  final String name;
  final String id;
  final String? avatar;
  final String? category;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            avatar ?? 'https://via.placeholder.com/150',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                width: 100,
                height: 100,
                color: Colors.grey.shade300,
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 100,
                height: 100,
                color: Colors.grey.shade300,
                child: const Icon(Icons.image_rounded, size: 40, color: Colors.pink),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Text(name),
        const SizedBox(height: 4),
        Text(category ?? 'Chưa cập nhật'),
      ],
    );
  }
}
