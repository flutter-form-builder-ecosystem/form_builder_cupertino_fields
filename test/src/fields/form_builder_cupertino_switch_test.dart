import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_cupertino_fields/form_builder_cupertino_fields.dart';
import '../form_builder_tester.dart';

void main() {
  group('initialValue -', () {
    testWidgets('should initial value when set initialValue',
        (WidgetTester tester) async {
      const widgetName = 'sc1';
      final switchKey = GlobalKey<FormBuilderFieldState>();
      final testWidget = FormBuilderCupertinoSwitch(
        name: widgetName,
        initialValue: true,
        key: switchKey,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(switchKey.currentState!.value, isTrue);
    });
  });

  group('errors -', () {
    testWidgets('should error text when value is false',
        (WidgetTester tester) async {
      const widgetName = 'sc1';
      const errorTextField = 'error text field';
      final switchKey = GlobalKey<FormBuilderFieldState>();
      final testWidget = FormBuilderCupertinoSwitch(
        name: widgetName,
        key: switchKey,
        validator: (value) => value == null || !value ? errorTextField : null,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      switchKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text(errorTextField), findsOneWidget);

      await tester.tap(find.byType(CupertinoSwitch));
      await tester.pumpAndSettle();

      switchKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text(errorTextField), findsNothing);
    });
    testWidgets('should custom error text when invalidate field',
        (WidgetTester tester) async {
      const widgetName = 'sc1';
      const errorTextField = 'error text field';
      final switchKey = GlobalKey<FormBuilderFieldState>();
      final testWidget = FormBuilderCupertinoSwitch(
        name: widgetName,
        key: switchKey,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      switchKey.currentState!.invalidate(errorTextField);
      await tester.pumpAndSettle();

      expect(find.text(errorTextField), findsOneWidget);
    });
    testWidgets('should not show error text when value is true',
        (WidgetTester tester) async {
      const widgetName = 'sc1';
      final switchKey = GlobalKey<FormBuilderFieldState>();
      const errorTextField = 'error text field';
      final testWidget = FormBuilderCupertinoSwitch(
        name: widgetName,
        key: switchKey,
        validator: (value) => value == null || !value ? errorTextField : null,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      await tester.tap(find.byType(CupertinoSwitch));
      await tester.pumpAndSettle();

      switchKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text(errorTextField), findsNothing);
    });
  });

  group('reset -', () {
    testWidgets('Should reset to null when call reset', (tester) async {
      const widgetName = 'sc1';
      final switchKey = GlobalKey<FormBuilderFieldState>();
      final testWidget = FormBuilderCupertinoSwitch(
        name: widgetName,
        key: switchKey,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      switchKey.currentState?.setValue(true);
      await tester.pumpAndSettle();
      switchKey.currentState?.reset();

      expect(switchKey.currentState?.value, null);
    });
    testWidgets('Should reset to initial when call reset', (tester) async {
      const widgetName = 'sc1';
      final switchKey = GlobalKey<FormBuilderFieldState>();
      const initialValue = true;
      final testWidget = FormBuilderCupertinoSwitch(
        name: widgetName,
        key: switchKey,
        initialValue: initialValue,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      switchKey.currentState?.setValue(false);
      await tester.pumpAndSettle();
      switchKey.currentState?.reset();

      expect(switchKey.currentState?.value, equals(initialValue));
    });
    testWidgets(
        'Should reset custom error when invalidate field and then reset',
        (tester) async {
      const widgetName = 'sc1';
      final switchKey = GlobalKey<FormBuilderFieldState>();
      const errorTextField = 'error text field';
      final testWidget = FormBuilderCupertinoSwitch(
        name: widgetName,
        key: switchKey,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      switchKey.currentState?.invalidate(errorTextField);
      await tester.pumpAndSettle();

      // Reset custom error
      switchKey.currentState?.reset();
      await tester.pumpAndSettle();
      expect(find.text(errorTextField), findsNothing);
    });
  });
}
