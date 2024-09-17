import 'package:flutter/material.dart';

import '../../../../core/shared/presentation/widgets/search_postal_code_text_field_widget.dart';

class SearchPostalCodesFieldWidget extends StatelessWidget {
  const SearchPostalCodesFieldWidget({
    Key? key,
    required this.controller,
    required this.onTap,
  }) : super(key: key);

  final TextEditingController controller;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SearchPostalCodesTextFieldWidget(
          textColor: Colors.black,
          postalCodesEditingController: controller,
          isEnabled: false,
          onTap: onTap,
        ),
      ),
    );
  }
}
