import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_shortener/const/app_colors.dart';
import '../const/text_styles.dart';

typedef OnClickTypeAheadSuggestion = void Function(String)?;

class CustomNewTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool isPassword;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool showRequired;
  final VoidCallback? onTap;
  final bool readOnly;
  final int? maxLines;
  final EdgeInsets? contentPadding;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? prefixText;
  final TextStyle? hintStyle;
  final bool isFilled;
  final bool isNewLabel;
  final TextAlign? textAlign;
  final double? borderRadius;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final String? initialValue;
  final bool? autoFocus;
  final TextInputAction? textInputAction;
  final Color? titleColor;
  final FocusNode? focusNode;
  final double? sufixIconSize;
  final int? length;
  final Color? borderColor;
  final Color? focusBorderColor;


  const CustomNewTextField({
    Key? key,
    required this.labelText,
    this.focusNode,
    this.controller,
    this.focusBorderColor,
    this.length,
    this.borderColor,
    this.sufixIconSize,
    this.isPassword = false,
    this.validator,
    this.keyboardType,
    this.hintText,
    this.showRequired = false,
    this.readOnly = false,
    this.onTap,
    this.maxLines,
    this.contentPadding,
    this.suffixIcon,
    this.isFilled = false,
    // this.labelStyle,
    this.isNewLabel = false,
    this.prefixIcon,
    this.onSubmitted,
    this.onChanged,
    this.initialValue,
    this.autoFocus = false,
    this.textInputAction,
    this.textAlign,
    this.prefixText,
    this.borderRadius,
    this.hintStyle,
    this.titleColor,
  }) : super(key: key);

  @override
  State<CustomNewTextField> createState() => _CustomNewTextFieldState();
}

class _CustomNewTextFieldState extends State<CustomNewTextField> {
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderSide:  BorderSide(color: widget.borderColor?? AppColors.lightDivider),
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.0),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText.isNotEmpty) ...[
          RichText(
            text: TextSpan(
              text: widget.labelText,
              style: w4f14(AppColors.textBlack),
              children: [
                if (widget.showRequired) ...{
                  const TextSpan(
                    text: " *",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: AppColors.red,
                      fontFamily: "Inter",
                    ),
                  ),
                }
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
        TextFormField(
          focusNode: widget.focusNode,
          textAlign: widget.textAlign ?? TextAlign.start,
          initialValue: widget.initialValue,
          readOnly: widget.readOnly,
          inputFormatters: [ LengthLimitingTextInputFormatter(widget.length),],
          keyboardType: widget.keyboardType,
          obscureText: (widget.isPassword) ? _showPassword : false,
          controller: widget.controller,
          autofocus: widget.autoFocus ?? false,
          validator: widget.validator,
          cursorColor: Colors.black12,
          onTap: widget.onTap,
          maxLines: widget.maxLines ?? 1,
          onChanged: widget.onChanged,
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          decoration: InputDecoration(
            prefixText: widget.prefixText,
            suffixIconConstraints: widget.sufixIconSize != null
                ? BoxConstraints(
                    minHeight: widget.sufixIconSize!,
                minWidth: widget.sufixIconSize!)
                : null,
            prefixStyle:
                const TextStyle(color: Colors.black12, fontSize: 16),
            fillColor: widget.isFilled ? AppColors.red : Colors.white,
            filled: true,
            errorMaxLines: 2,
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:  BorderSide(
                color: widget.focusBorderColor??AppColors.lightDivider,
              ),
            ),
            errorBorder: outlineInputBorder.copyWith(
              borderSide: const BorderSide(color: Colors.red),
            ),
            disabledBorder: outlineInputBorder,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ??
                const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon ??
                (widget.isPassword
                    ? InkWell(
                        onTap: () =>
                            setState(() => _showPassword = !_showPassword),
                        child: _showPassword
                            ? const Icon(
                                Icons.visibility_off_outlined,
                                size: 18.0,
                                color: Colors.black,
                              )
                            : const Icon(
                                Icons.visibility_outlined,
                                size: 18.0,
                                color: Colors.black,
                              ),
                      )
                    : null),
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
          ),
          onFieldSubmitted: widget.onSubmitted,
        ),
      ],
    );
  }
}
