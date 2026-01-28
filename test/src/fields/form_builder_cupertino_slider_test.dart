import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_cupertino_fields/form_builder_cupertino_fields.dart';
import '../form_builder_tester.dart';

void main() {
  // Copy from `cupertino/slider_test.dart` on Flutter source code
  Future<void> dragSlider(WidgetTester tester) {
    final Offset topLeft = tester.getTopLeft(find.byType(CupertinoSlider));
    const double unit = CupertinoThumbPainter.radius;
    const double delta = 3.0 * unit;
    return tester.dragFrom(
      topLeft + const Offset(unit, unit),
      const Offset(delta, 0.0),
    );
  }

  group('initialValue -', () {
    testWidgets('should initial value when set initialValue', (
      WidgetTester tester,
    ) async {
      const widgetName = 'sc1';
      final switchKey =
          GlobalKey<
            FormBuilderFieldState<FormBuilderCupertinoSlider, double>
          >();
      final testWidget = FormBuilderCupertinoSlider(
        name: widgetName,
        max: 100,
        min: 1,
        initialValue: 5,
        key: switchKey,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(switchKey.currentState!.value, 5);
    });
  });

  group('errors -', () {
    testWidgets('should error text when value is bigger than 0', (
      WidgetTester tester,
    ) async {
      const widgetName = 'sc1';
      const errorTextField = 'error text field';
      final switchKey =
          GlobalKey<
            FormBuilderFieldState<FormBuilderCupertinoSlider, double>
          >();
      final testWidget = FormBuilderCupertinoSlider(
        name: widgetName,
        key: switchKey,
        max: 10,
        min: 0,
        initialValue: 0,
        validator: (value) =>
            value == null || value <= 0 ? errorTextField : null,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      switchKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text(errorTextField), findsOneWidget);

      await dragSlider(tester);
      await tester.pump();

      switchKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text(errorTextField), findsNothing);
    });
    testWidgets('should custom error text when invalidate field', (
      WidgetTester tester,
    ) async {
      const widgetName = 'sc1';
      const errorTextField = 'error text field';
      final switchKey =
          GlobalKey<
            FormBuilderFieldState<FormBuilderCupertinoSlider, double>
          >();
      final testWidget = FormBuilderCupertinoSlider(
        name: widgetName,
        key: switchKey,
        max: 10,
        min: 0,
        initialValue: 0,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      switchKey.currentState!.invalidate(errorTextField);
      await tester.pumpAndSettle();

      expect(find.text(errorTextField), findsOneWidget);
    });
    testWidgets('should not show error text when value is bigger than 0', (
      WidgetTester tester,
    ) async {
      const widgetName = 'sc1';
      final switchKey =
          GlobalKey<
            FormBuilderFieldState<FormBuilderCupertinoSlider, double>
          >();
      const errorTextField = 'error text field';
      final testWidget = FormBuilderCupertinoSlider(
        name: widgetName,
        key: switchKey,
        max: 10,
        min: 0,
        initialValue: 0,
        validator: (value) =>
            value == null || value <= 0 ? errorTextField : null,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      await dragSlider(tester);
      await tester.pumpAndSettle();

      switchKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text(errorTextField), findsNothing);
    });
  });

  group('reset -', () {
    testWidgets('Should reset to null when call reset', (tester) async {
      const widgetName = 'sc1';
      final switchKey =
          GlobalKey<
            FormBuilderFieldState<FormBuilderCupertinoSlider, double>
          >();
      final testWidget = FormBuilderCupertinoSlider(
        name: widgetName,
        key: switchKey,
        max: 10,
        min: 0,
        initialValue: 0,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      switchKey.currentState?.setValue(5.0);
      await tester.pumpAndSettle();
      switchKey.currentState?.reset();

      expect(switchKey.currentState?.value, 0);
    });
    testWidgets('Should reset to initial when call reset', (tester) async {
      const widgetName = 'sc1';
      final switchKey =
          GlobalKey<
            FormBuilderFieldState<FormBuilderCupertinoSlider, double>
          >();
      const double initialValue = 0;
      final testWidget = FormBuilderCupertinoSlider(
        name: widgetName,
        key: switchKey,
        initialValue: initialValue,
        max: 10,
        min: 0,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      switchKey.currentState?.setValue(5.0);
      await tester.pumpAndSettle();
      switchKey.currentState?.reset();

      expect(switchKey.currentState?.value, equals(initialValue));
    });
    testWidgets(
      'Should reset custom error when invalidate field and then reset',
      (tester) async {
        const widgetName = 'sc1';
        final switchKey =
            GlobalKey<
              FormBuilderFieldState<FormBuilderCupertinoSlider, double>
            >();
        const errorTextField = 'error text field';
        final testWidget = FormBuilderCupertinoSlider(
          name: widgetName,
          key: switchKey,
          max: 10,
          min: 0,
          initialValue: 0,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        switchKey.currentState?.invalidate(errorTextField);
        await tester.pumpAndSettle();

        // Reset custom error
        switchKey.currentState?.reset();
        await tester.pumpAndSettle();
        expect(find.text(errorTextField), findsNothing);
      },
    );
  });
}
