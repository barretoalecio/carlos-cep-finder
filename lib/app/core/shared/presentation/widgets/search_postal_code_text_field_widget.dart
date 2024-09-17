import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchPostalCodesTextFieldWidget extends StatelessWidget {
  const SearchPostalCodesTextFieldWidget({
    super.key,
    required this.postalCodesEditingController,
    required this.isEnabled,
    this.textColor,
    this.onTap,
    this.onEditingController,
    this.onChanged,
  }) : assert(
          !(isEnabled && onTap != null),
          'onTap must be null when isEnabled is true',
        );

  final TextEditingController postalCodesEditingController;
  final Color? textColor;
  final bool isEnabled;
  final VoidCallback? onTap;
  final Function()? onEditingController;
  final Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              offset: const Offset(1, 4),
              spreadRadius: 0,
              color: const Color(0xFF707079).withOpacity(0.32),
            ),
          ],
          color: colorScheme.secondary,
        ),
        child: Center(
          child: TextFormField(
            onChanged: onChanged,
            onEditingComplete: onEditingController,
            style: theme.textTheme.titleMedium?.copyWith(
              color: textColor ?? colorScheme.onSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(8),
            ],
            controller: postalCodesEditingController,
            enabled: isEnabled,
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Icon(
                  Icons.search,
                  color: colorScheme.onSecondary,
                  size: 28,
                ),
              ),
              hintText: 'Buscar',
              hintStyle: theme.textTheme.titleMedium?.copyWith(
                color: colorScheme.onSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
