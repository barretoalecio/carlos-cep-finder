import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konsi_desafio_flutter/app/core/shared/presentation/pages/error_page.dart';
import 'package:mocktail/mocktail.dart';

class MockSvgPicture extends Mock implements SvgPicture {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }
}

void main() {
  setUpAll(() {
    registerFallbackValue(MockSvgPicture());
  });

  group('Error Page', () {
    testWidgets('Should display the error message and the correct SVG image',
        (WidgetTester tester) async {
      const errorMessage = 'Something went wrong!';

      await tester.pumpWidget(
        const MaterialApp(
          home: ErrorPage(
            message: errorMessage,
          ),
        ),
      );

      expect(find.byType(SvgPicture), findsOneWidget);

      expect(find.text(errorMessage), findsOneWidget);

      final textWidget = tester.widget<Text>(find.text(errorMessage));
      final textStyle = textWidget.style!;

      expect(textStyle.fontWeight, FontWeight.bold);
      expect(textStyle.color, const Color(0xff6750a4));
    });
  });
}
