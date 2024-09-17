import 'package:flutter/material.dart';

import '../../../../core/utils/extensions/string_extension.dart';
import '../../domain/entities/address_data_entity.dart';

class AddressItemTileWidget extends StatelessWidget {
  const AddressItemTileWidget({
    super.key,
    required this.address,
    required this.onTap,
    required this.onDelete,
  });

  final AddressDataEntity address;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(address.postalCode.toPostalCodeFormat()),
      titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
            fontSize: 20.0,
            color: const Color(0xFF141514),
          ),
      subtitleTextStyle: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
        color: Color(0xFF49454F),
      ),
      trailing: GestureDetector(
        onTap: onDelete,
        child: CircleAvatar(
          radius: 24.0,
          backgroundColor: const Color(0xFFF0F6F5),
          child: Icon(
            Icons.bookmark,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      subtitle: Text(
        '${address.fullAddress}',
      ),
    );
  }
}
