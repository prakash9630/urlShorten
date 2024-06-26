import 'package:flutter/material.dart';
import 'package:url_shortener/const/app_colors.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.isLoading = false,
    this.buttonColor,
    this.trailingIcon,
    this.textColor,
    this.hasIcon = true,
    required this.buttonText,
    required this.onPressed,
    this.leadingWidget,
    this.borderRadiusGeometry,
    this.fontSize,
    this.verticalPadding,
    this.textPadding,
    this.borderColor,
    this.buttontextStyle,
  }) : super(key: key);
  final String buttonText;
  final Color? buttonColor;
  final VoidCallback onPressed;
  final Widget? leadingWidget;
  final bool isLoading;
  final Widget? trailingIcon;
  final Color? textColor;
  final bool hasIcon;
  final double? borderRadiusGeometry;
  final double? fontSize;
  final double? verticalPadding;
  final EdgeInsetsGeometry? textPadding;
  final Color? borderColor;
  final TextStyle? buttontextStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: isLoading ? null : onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 10,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.transparent),
          color: isLoading ? AppColors.secondaryColor : (buttonColor ?? AppColors.primaryColor),
          borderRadius: BorderRadius.circular(borderRadiusGeometry ?? 8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            leadingWidget ?? const SizedBox(),
            isLoading
                ? const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.transparent),
                      strokeWidth: 2.0,
                    ),
                  )
                : Padding(
                    padding: textPadding ??
                        EdgeInsets.only(
                          left: !hasIcon ? 0 : 15,
                          top: 2,
                        ),
                    child: Center(
                      child: Text(
                        buttonText,
                        textAlign: TextAlign.center,
                        style: buttontextStyle ??
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: fontSize ?? 17,
                                  fontWeight: FontWeight.w700,
                                  color: textColor ?? AppColors.white,
                                ),
                      ),
                    ),
                  ),
            isLoading
                ? const SizedBox()
                : hasIcon
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: trailingIcon ??
                            const Icon(
                              Icons.arrow_forward,
                              color: AppColors.white,
                            ),
                      )
                    : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
