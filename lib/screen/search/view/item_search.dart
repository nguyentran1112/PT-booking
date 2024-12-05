import 'package:fitness/models/search_item_model.dart';
import 'package:fitness/widgets/start_widget.dart';
import 'package:flutter/material.dart';

class ItemSearch extends StatelessWidget {
  const ItemSearch({super.key, required this.item});
  final SearchItemModel item;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          (item.image??'').isNotEmpty ?ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.image??'',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ): Container(
            width: 80,
            height: 80,
            color: Colors.grey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title??'',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    StartWidget(value: item.rating??0),
                    const SizedBox(width: 8),
                    Text(
                      '${item.rating??0}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${item.category}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}