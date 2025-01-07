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
  final List<String> imgList = [
    'https://iili.io/2gXv5Yv.png',
    'https://iili.io/2gXv5Yv.png',
    'https://iili.io/2gXv5Yv.png',
    'https://iili.io/2gXv5Yv.png',
    'https://iili.io/2gXv5Yv.png',
    'https://iili.io/2gXv5Yv.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Expanded(
            child: CarouselSlider(
              items: imgList
                  .map((e) => SizedBox(
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ImageNetworkCacheCommon(
                              imageUrl: e, fit: BoxFit.fill),
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
