import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/shared/presentation/widgets/buttons/filled_buttons.dart';
import '../../../../core/utils/extensions/string_extension.dart';

abstract class NotebookInteractors {
  const NotebookInteractors();
  Future<void> showConfirmDialog(
    BuildContext context, {
    required String postalCode,
    required Function onContinue,
  });
}

class NotebookInteractorsImplementation implements NotebookInteractors {
  @override
  Future<void> showConfirmDialog(
    BuildContext context, {
    required String postalCode,
    required Function onContinue,
  }) async {
    final Widget dialog = Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.delete_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 8),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: 'Tem certeza que deseja apagar o registro ',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    TextSpan(
                      text: postalCode.toPostalCodeFormat(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.0,
                      ),
                    ),
                    TextSpan(
                      text: '? Essa ação não poderá ser desfeita.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: MediumButton(
                      onPressed: () => Modular.to.maybePop(context),
                      text: 'CANCELAR',
                      borderRadius: 8.0,
                      buttonColor: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: MediumButton(
                      onPressed: () {
                        Modular.to.maybePop(context);
                        onContinue();
                      },
                      text: 'CONTINUAR',
                      borderRadius: 8.0,
                      buttonColor: Theme.of(context).colorScheme.primary,
                      textColor: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    showDialog(context: context, builder: (context) => dialog);
  }
}
