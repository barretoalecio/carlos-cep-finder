import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/assets/svg_assets.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({required this.message, Key? key}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset(
                SvgAssets.error,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Text(
                  '$message',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
