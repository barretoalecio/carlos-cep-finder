import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controllers/states/abstractions/app_state.dart';
import '../../controllers/states/abstractions/error_state.dart';
import '../../controllers/states/abstractions/processing_state.dart';

class KonsiSnackBar {
  const KonsiSnackBar();

  static void showSnackBar(
    BuildContext context,
    AppState state, {
    Color? backgroundColor,
    IconData? icon,
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (state is ProcessingState) {
      backgroundColor = colorScheme.onPrimaryContainer;
      icon = null;
    } else if (state is ErrorState) {
      backgroundColor = colorScheme.error;
      icon = Icons.error_outline_outlined;
    } else {
      backgroundColor = colorScheme.primary;
      icon = Icons.check_circle_outline;
    }

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(milliseconds: 1500),
      elevation: 0,
      content: Row(
        children: [
          if (icon == null)
            const CupertinoActivityIndicator()
          else
            Icon(
              icon,
              color: colorScheme.surface,
            ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              state.message,
              style: theme.textTheme.titleMedium
                  ?.copyWith(color: colorScheme.surface),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void hideSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }
}
