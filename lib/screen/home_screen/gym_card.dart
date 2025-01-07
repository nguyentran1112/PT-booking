import 'package:fitness/common/image_network_cache_common.dart';
import 'package:fitness/models/gym_room_model.dart';
import 'package:fitness/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

enum Algin { horizontal, vertical }

class GymCard extends StatefulWidget {
  const GymCard(
      {super.key, this.algin = Algin.vertical, required this.gymRoomModel});
  final Algin algin;
  final GymRoomModel gymRoomModel;
  @override
  State<GymCard> createState() => _GymCardState();
}

class _GymCardState extends State<GymCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.algin == Algin.horizontal) {
      return Row(
        children: [
          SizedBox(
            width: 105,
            height: 105,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ImageNetworkCacheCommon(
                imageUrl:
                    widget.gymRoomModel.avatar ?? 'https://iili.io/2g3elvS.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.gymRoomModel.name ?? '',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: ColorUtils.fromHex('#303030')),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  RatingBarIndicator(
                    itemSize: 12,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    rating: widget.gymRoomModel.rating ?? 0,
                  ),
                  Text(
                    (widget.gymRoomModel.rating ?? 0).toStringAsFixed(1),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: ColorUtils.fromHex('#303030')),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: NumberFormat.currency(
                    decimalDigits: 0,
                    locale: 'vi',
                    symbol: 'đ',
                  ).format(widget.gymRoomModel.price),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: ColorUtils.fromHex('#303030')),
                ),
                TextSpan(
                  text: '/tháng',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: ColorUtils.fromHex('#8A8A8A')),
                ),
              ]))
            ],
          )),
          const SizedBox(
            width: 30,
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite,
                color: ColorUtils.fromHex('#FF5148'),
              ))
        ],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const ImageNetworkCacheCommon(
              imageUrl: 'https://iili.io/2g3elvS.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(
                widget.gymRoomModel.name ?? '',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: ColorUtils.fromHex('#303030')),
              ),
            ),
            Row(
              children: [
                Text(
                  (widget.gymRoomModel.rating ?? 0).toStringAsFixed(1),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: ColorUtils.fromHex('#303030')),
                ),
                Icon(Icons.star, color: ColorUtils.fromHex('#FFD912')),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        RichText(
            text: TextSpan(children: [
          TextSpan(
            text: NumberFormat.currency(
              decimalDigits: 0,
              locale: 'vi',
              symbol: 'đ',
            ).format(widget.gymRoomModel.price),
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: ColorUtils.fromHex('#303030')),
          ),
          TextSpan(
            text: '/tháng',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: ColorUtils.fromHex('#8A8A8A')),
          ),
        ]))
      ],
    );
  }
}
