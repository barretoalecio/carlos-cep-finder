import 'package:flutter/material.dart';

class MediumButton extends StatelessWidget {
  const MediumButton({
    Key? key,
    this.padding,
    this.enableButton = true,
    this.disabledColor,
    this.enableText = true,
    this.text,
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.white,
      fontSize: 18.0,
    ),
    this.textColor,
    this.buttonColor,
    this.borderRadius,
    required this.onPressed,
  }) : super(key: key);

  final Color? disabledColor;
  final bool enableButton;
  final EdgeInsets? padding;

  final bool enableText;

  final String? text;

  final TextStyle? textStyle;
  final Color? textColor;
  final Color? buttonColor;
  final GestureTapCallback onPressed;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48, maxHeight: 48),
      child: _FilledButton(
        enableButton: enableButton,
        disabledColor: disabledColor,
        onPressed: onPressed,
        borderRadius: borderRadius,
        padding: padding ?? const EdgeInsets.all(12),
        buttonColor: buttonColor,
        enableText: enableText,
        text: text,
        textStyle: textStyle,
        textColor: textColor,
      ),
    );
  }
}

class _FilledButton extends StatelessWidget {
  _FilledButton({
    required this.enableButton,
    required this.disabledColor,
    required this.onPressed,
    required this.buttonColor,
    required this.enableText,
    required this.text,
    this.textStyle,
    this.textColor,
    this.padding,
    this.borderRadius,
  }) : assert(
          enableText ? text != null : true,
          throw Exception(
            'A text should be assigned if enableText is true',
          ),
        );

  final GestureTapCallback onPressed;
  final Color? buttonColor;
  final bool enableText;
  final String? text;
  final TextStyle? textStyle;
  final Color? textColor;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Color? disabledColor;
  final bool enableButton;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: enableButton ? onPressed : null,
      color: buttonColor ?? Theme.of(context).colorScheme.primary,
      disabledColor: disabledColor ??
          buttonColor?.withOpacity(0.5) ??
          Theme.of(context).colorScheme.primary.withOpacity(0.5),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 4),
      ),
      padding: padding,
      minWidth: 0,
      child: IntrinsicWidth(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (enableText) ...[
              Text(
                text!,
                overflow: TextOverflow.ellipsis,
                style: textStyle ??
                    Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: enableButton
                              ? textColor ?? Colors.white
                              : textColor?.withOpacity(0.5) ?? Colors.white,
                        ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
