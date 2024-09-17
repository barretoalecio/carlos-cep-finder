import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/utils/icons/konsi_icons.dart';

class PostalCodeItemTileShimmerWidget extends StatelessWidget {
  const PostalCodeItemTileShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Shimmer.fromColors(
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16.0),
          ),
          height: 20,
        ),
      ),
      leading: CircleAvatar(
        radius: 24.0,
        backgroundColor: Colors.grey.shade200,
        child: const Icon(
          KonsiIcons.marker,
          color: Colors.grey,
          size: 20,
        ),
      ),
      subtitle: Shimmer.fromColors(
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16.0),
          ),
          height: 16,
        ),
      ),
    );
  }
}
