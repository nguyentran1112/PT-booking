import 'package:fitness/utils/color_utils.dart';
import 'package:fitness/utils/debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TextSearchCommon extends StatefulWidget {
  const TextSearchCommon({super.key, this.onChanged});
  final ValueChanged<String>? onChanged;

  @override
  State<TextSearchCommon> createState() => _TextSearchCommonState();
}

class _TextSearchCommonState extends State<TextSearchCommon> {
  final Debounce _debounce = Debounce(milliseconds: 500,);
  _onChanged(String value) {
    _debounce.run(() {
      widget.onChanged!(value);
    });
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Tìm kiếm',
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SvgPicture.asset(
            'assets/search.svg',
            colorFilter: ColorFilter.mode(
                ColorUtils.fromHex('#FA6400'), BlendMode.srcIn),
            fit: BoxFit.scaleDown,
          ),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        filled: true,
        isDense: true,
        fillColor: ColorUtils.fromHex('#F6F6F6'),
          
      ),
      onChanged: _onChanged,
    );
  }
}