import 'package:flutter/material.dart';

import '../../../../core/utils/extensions/string_extension.dart';

class PostalCodeTextWidget extends StatelessWidget {
  const PostalCodeTextWidget({
    Key? key,
    required this.postalCode,
  }) : super(key: key);

  final String postalCode;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        postalCode.length == 8 ? postalCode.toPostalCodeFormat() : '',
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontWeight: FontWeight.w600,
          fontSize: 18.0,
          shadows: const [
            Shadow(offset: Offset(-1.5, -1.5), color: Colors.white),
            Shadow(offset: Offset(1.5, -1.5), color: Colors.white),
            Shadow(offset: Offset(1.5, 1.5), color: Colors.white),
            Shadow(offset: Offset(-1.5, 1.5), color: Colors.white),
          ],
        ),
      ),
    );
  }
}
