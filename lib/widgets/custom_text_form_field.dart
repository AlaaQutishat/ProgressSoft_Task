import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../core/utils/color_constant.dart';


class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    this.alignment,
    this.width,
    this.radius,
    this.borderSid,
    this.scrollPadding,
    this.controller,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    thisintText,
    thisintStyle,
    this.enable,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.direction = false,
    this.isPhone = false,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    thisalidator,
    this.maxLength,
    this.context,
    this.textCapitalization = TextCapitalization.none,
    this.center,
    this.labelText, this.hintText, this.hintStyle, this.validator,
  }) : super(
    key: key,
  );

  final Alignment? alignment;

  final double? width;

  final TextEditingController? scrollPadding;

  final TextEditingController? controller;

  final Color? borderSid;
  final TextStyle? textStyle;

  final bool? obscureText;
  final bool? enable;
  final bool isPhone;
  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;
  final int? maxLength;
  final int? radius;
  final String? hintText;
  final String? labelText;
  final BuildContext? context ;
  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;
  final bool direction;
  final bool? center;
  TextCapitalization textCapitalization;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment ?? Alignment.center,
      child: textFormFieldWidget,
    )
        : labelText != null
        ? Column(
      mainAxisAlignment: direction == true
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: direction == true
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(labelText!,
            )
             ,
        const SizedBox(
          height: 5,
        ),
        textFormFieldWidget
      ],
    )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => SizedBox(
    width: width ?? double.maxFinite,
    child: TextFormField(
      maxLength: maxLength ?? null,
      textAlign: center != null ? TextAlign.center : TextAlign.start,
      enabled: enable ?? true,
      scrollPadding: EdgeInsets.only(
          bottom: MediaQuery.of(context!).viewInsets.bottom),
      controller: controller,
      textCapitalization: textCapitalization!,

      obscureText: obscureText!,
      textInputAction: textInputAction,
      keyboardType: isPhone == true
          ? Platform.isIOS
          ? const TextInputType.numberWithOptions(
          decimal: true, signed: true)
          : TextInputType.phone
          : textInputType,
      inputFormatters:
      isPhone == true ? [FilteringTextInputFormatter.digitsOnly] : [],
      maxLines: maxLines ?? 1,
      decoration: decoration,
      validator: validator,
    ),
  );
  InputDecoration get decoration => InputDecoration(
    hintText: hintText ?? "",
    counterText: '',
    prefixIcon: prefix,
    prefixIconConstraints: prefixConstraints,
    suffixIcon: suffix,
    suffixIconConstraints: suffixConstraints,
    isDense: true,
    contentPadding: contentPadding ??
        const EdgeInsets.symmetric(
          horizontal: 11,
          vertical: 16,
        ),
    
    filled: filled,
    border: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              radius != null ? radius!.toDouble() : 16),
          borderSide: BorderSide(
            color: borderSid ?? ColorConstant.primaryColor,
            width: 1,
          ),
        ),
    enabledBorder: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              radius != null ? radius!.toDouble() : 16),
          borderSide: BorderSide(
            color: borderSid ?? ColorConstant.fromHex("#D6D6D6"),
            width: 1,
          ),
        ),
    focusedBorder: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              radius != null ? radius!.toDouble() : 16),
          borderSide: BorderSide(
            color: borderSid ?? ColorConstant.fromHex("#D6D6D6"),
            width: 1,
          ),
        ),
  );
}

/// Extension on [CustomTextFormField] to facilitate inclusion of all types of border style etc
extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get outlineGray => OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(
      color: Colors.grey,
      width: 1,
    ),
  );
  static OutlineInputBorder get fillGray => OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide.none,
  );
  static OutlineInputBorder get outlineBlueGrayTL10 => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.blueGrey,
      width: 1,
    ),
  );
}
