import 'package:fitness/common/image_network_cache_common.dart';
import 'package:fitness/models/user_model.dart';
import 'package:fitness/routing/router_constants.dart';
import 'package:fitness/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

enum Algin { horizontal, vertical }

class PartnerCard extends StatefulWidget {
  const PartnerCard(
      {super.key, this.algin = Algin.vertical, required this.userModel});
  final Algin algin;
  final UserModel userModel;
  @override
  State<PartnerCard> createState() => _PartnerCardState();
}

class _PartnerCardState extends State<PartnerCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.algin == Algin.horizontal) {
      return GestureDetector(
        onTap: () {
          context.goNamed(RouterConstants.partnerDetail.name,
              pathParameters: {'id': widget.userModel.id ?? ''});
        },
        child: Row(
          children: [
            SizedBox(
              width: 105,
              height: 105,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ImageNetworkCacheCommon(
                  base64:
                      widget.userModel.avatar ?? 'https://iili.io/2g3elvS.png',
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
                  widget.userModel.name ?? '',
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
                      rating: widget.userModel.rating ?? 0,
                    ),
                    Text(
                      (widget.userModel.rating ?? 0).toStringAsFixed(1),
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
                    ).format(widget.userModel.price),
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
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        context.goNamed(RouterConstants.partnerDetail.name,
            pathParameters: {'id': widget.userModel.id ?? ''});
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ImageNetworkCacheCommon(
                base64:
                    widget.userModel.avatar ?? 'https://iili.io/2g3elvS.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.userModel.name ?? '',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: ColorUtils.fromHex('#303030')),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // RichText(
          //     text: TextSpan(children: [
          //   TextSpan(
          //     text: NumberFormat.currency(
          //       decimalDigits: 0,
          //       locale: 'vi',
          //       symbol: 'đ',
          //     ).format(widget.userModel.price),
          //     style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.w300,
          //         color: ColorUtils.fromHex('#303030')),
          //   ),
          //   TextSpan(
          //     text: '/tháng',
          //     style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.w300,
          //         color: ColorUtils.fromHex('#8A8A8A')),
          //   ),
          // ])),
          Chip(
            label: const Text('Tăng cơ'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.white,
            labelStyle: const TextStyle(
              color: Colors.grey,
            ),
            side: BorderSide(
              color: ColorUtils.fromHex('#FA6400'),
              width: 2, // Border width
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                (widget.userModel.rating ?? 0).toStringAsFixed(1),
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
    );
  }
}
