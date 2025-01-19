import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitness/common/image_network_cache_common.dart';
import 'package:fitness/utils/color_utils.dart';
import 'package:flutter/material.dart';

class BannerView extends StatefulWidget {
  const BannerView({super.key});

  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  final String imgs =
      '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';
  List<String> imgList = [];
  @override
  void initState() {
    imgList = [
      imgs,
      imgs,
      imgs,
      imgs,
      imgs,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider(
            items: imgList
                .map((e) => SizedBox(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: ImageNetworkCacheCommon(
                            base64: e, fit: BoxFit.fill),
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
              height: 145,
              autoPlay: true,
              enlargeCenterPage: false,
              viewportFraction: 1,
              padEnds: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 6.0,
                  height: 6.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? ColorUtils.fromHex('#FFFFFF59')
                              : ColorUtils.fromHex('#FFFFFF'))
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
