import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/assets/json_assets.dart';
import '../../../utils/mixins/no_internet_mixin.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({required this.onAnimationCompleted});
  final void Function() onAnimationCompleted;

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with NoInternetMixin {
  double opacity = 0.0;
  double scale = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 1),
      () => setState(() {
        opacity = 1;
        scale = 2;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  child: AnimatedScale(
                    scale: scale,
                    duration: const Duration(milliseconds: 500),
                    child: Lottie.asset(JsonAssets.splashAnimation),
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: opacity,
                onEnd: () async => await Future.delayed(
                  const Duration(seconds: 1),
                  widget.onAnimationCompleted,
                ),
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOutQuart,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: RichText(
                    text: TextSpan(
                      text: 'Desenvolvido por ',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Alécio Barreto',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
