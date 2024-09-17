import 'package:flutter/material.dart';

import '../../../../core/shared/presentation/widgets/buttons/filled_buttons.dart';
import '../../../../core/utils/extensions/string_extension.dart';

abstract class MapInteractors {
  const MapInteractors();
  Future<void> showDetailsBottomSheet(
    BuildContext context, {
    required String postalCode,
    required String fullAddress,
    required Function onTap,
  });
}

class MapInteractorsImplementation implements MapInteractors {
  @override
  Future<void> showDetailsBottomSheet(
    BuildContext context, {
    required String postalCode,
    required String fullAddress,
    required Function onTap,
  }) async {
    final Widget bottomSheet = IntrinsicHeight(
      child: Material(
        elevation: 10,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28.0),
              topRight: Radius.circular(28.0),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE8E8E8).withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 32,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondaryFixed
                          .withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      postalCode.length == 8
                          ? postalCode.toPostalCodeFormat()
                          : '',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    fullAddress,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF49454F),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SizedBox(
                    height: 56,
                    child: MediumButton(
                      onPressed: () => onTap(),
                      borderRadius: 5,
                      enableText: true,
                      text: 'Salvar endereço',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      builder: (_) => bottomSheet,
    );
  }
}
