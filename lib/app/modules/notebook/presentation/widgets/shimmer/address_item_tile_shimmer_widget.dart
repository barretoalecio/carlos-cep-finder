import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AddressItemTileShimmerWidget extends StatelessWidget {
  const AddressItemTileShimmerWidget({super.key});

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
      trailing: CircleAvatar(
        radius: 24.0,
        backgroundColor: Colors.grey.shade200,
        child: const Icon(
          Icons.bookmark,
          color: Colors.grey,
        ),
      ),
    );
  }
}
