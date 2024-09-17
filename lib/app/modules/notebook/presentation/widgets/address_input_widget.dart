import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddressInputWidget extends StatelessWidget {
  const AddressInputWidget({
    super.key,
    required this.textEditingController,
    required this.labelText,
    required this.enabled,
    this.initialValue,
    this.textInputType,
    this.inputFormatters,
  });

  final TextEditingController textEditingController;
  final String labelText;
  final bool enabled;
  final String? initialValue;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      inputFormatters: inputFormatters,
      keyboardType: textInputType,
      controller: textEditingController,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
        color: enabled
            ? const Color(0xFF393535)
            : Theme.of(context).colorScheme.onSecondary,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Color(0xFF545454),
          fontWeight: FontWeight.w500,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
      initialValue: initialValue,
    );
  }
}
