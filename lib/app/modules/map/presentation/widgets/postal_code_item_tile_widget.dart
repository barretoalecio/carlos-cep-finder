import 'package:flutter/material.dart';

import '../../../../core/utils/extensions/postal_code_extension.dart';
import '../../../../core/utils/extensions/string_extension.dart';
import '../../../../core/utils/icons/konsi_icons.dart';
import '../../domain/entities/postal_code_entity.dart';

class PostalCodeItemTileWidget extends StatelessWidget {
  const PostalCodeItemTileWidget({
    super.key,
    required this.postalCode,
    required this.onTap,
  });

  final PostalCodeEntity postalCode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(postalCode.postalCode.toPostalCodeFormat()),
      titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
            fontSize: 20.0,
            color: Colors.black,
          ),
      subtitleTextStyle: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
        color: Color(0xFF49454F),
      ),
      leading: CircleAvatar(
        radius: 24.0,
        backgroundColor: const Color(0xFFF0F6F5),
        child: Icon(
          KonsiIcons.marker,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
      ),
      subtitle: Text(
        postalCode.formattedAddress,
      ),
    );
  }
}
