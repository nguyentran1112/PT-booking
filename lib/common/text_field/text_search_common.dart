import 'package:fitness/utils/debounce.dart';
import 'package:flutter/material.dart';

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
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: _onChanged,
    );
  }
}