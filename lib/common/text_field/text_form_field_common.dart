import 'package:fitness/common/custom_outline_border_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldCommon extends StatelessWidget {
  const TextFormFieldCommon(
      {super.key,
      this.onChanged,
      this.hintText,
      this.initialValue,
      this.obscureText,
      this.keyboardType,
      this.controller,
      this.labelText,
      this.errorText,
      this.prefixText,
      this.suffixIcon,
      this.prefixIcon,
      this.enabled,
      this.readOnly,
      this.maxLines,
      this.minLines,
      this.autofocus,
      this.autocorrect,
      this.maxLength,
      this.inputFormatters,
      this.validator});
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final String? initialValue;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? labelText;
  final String? errorText;
  final String? prefixText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? enabled;
  final bool? readOnly;
  final int? maxLines;
  final int? minLines;
  final bool? autofocus;
  final bool? autocorrect;
  final int? maxLength;
  final String Function(String? value)? validator;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      initialValue: initialValue,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          errorText: errorText,
          prefixText: prefixText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: CustomOutlineInputBorder()),
      inputFormatters: inputFormatters,
      enabled: enabled ?? true,
      readOnly: readOnly ?? false,
      maxLines: maxLines,
      minLines: minLines,
      autofocus: autofocus ?? false,
      autocorrect: autocorrect ?? true,
      maxLength: maxLength,
      validator: validator,
    );
  }
}
