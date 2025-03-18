import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_cupertino_fields/form_builder_cupertino_fields.dart';
import '../form_builder_tester.dart';

void main() {
  group('initialValue -', () {
    testWidgets('should initial value when set initialValue', (
      WidgetTester tester,
    ) async {
      const widgetName = 'sc1';
      final textFieldKey = GlobalKey<FormBuilderFieldState>();
      final testWidget = FormBuilderCupertinoTextField(
        name: widgetName,
        initialValue: 'test',
        key: textFieldKey,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(textFieldKey.currentState!.value, equals('test'));
    });
  });

  group('errors -', () {
    testWidgets('should error text when value is empty', (
      WidgetTester tester,
    ) async {
      const widgetName = 'sc1';
      const errorTextField = 'error text field';
      final textFieldKey = GlobalKey<FormBuilderFieldState>();
      final testWidget = FormBuilderCupertinoTextField(
        name: widgetName,
        key: textFieldKey,
        validator:
            (value) => value == null || value.isEmpty ? errorTextField : null,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      textFieldKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text(errorTextField), findsOneWidget);

      await tester.enterText(find.byType(CupertinoTextField), 'test');
      await tester.pumpAndSettle();

      textFieldKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text(errorTextField), findsNothing);
    });
    testWidgets('should custom error text when invalidate field', (
      WidgetTester tester,
    ) async {
      const widgetName = 'sc1';
      const errorTextField = 'error text field';
      final textFieldKey = GlobalKey<FormBuilderFieldState>();
      final testWidget = FormBuilderCupertinoTextField(
        name: widgetName,
        key: textFieldKey,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      textFieldKey.currentState!.invalidate(errorTextField);
      await tester.pumpAndSettle();

      expect(find.text(errorTextField), findsOneWidget);
    });
    testWidgets('should not show error text when value is true', (
      WidgetTester tester,
    ) async {
      const widgetName = 'sc1';
      final textFieldKey = GlobalKey<FormBuilderFieldState>();
      const errorTextField = 'error text field';
      final testWidget = FormBuilderCupertinoTextField(
        name: widgetName,
        key: textFieldKey,
        validator:
            (value) => value == null || value.isEmpty ? errorTextField : null,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      await tester.enterText(find.byType(CupertinoTextField), 'test');
      await tester.pumpAndSettle();

      textFieldKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text(errorTextField), findsNothing);
    });
  });

  group('reset -', () {
    testWidgets('Should reset to null when call reset', (tester) async {
      const widgetName = 'sc1';
      final textFieldKey = GlobalKey<FormBuilderFieldState>();
      final testWidget = FormBuilderCupertinoTextField(
        name: widgetName,
        key: textFieldKey,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      textFieldKey.currentState?.setValue('test');
      await tester.pumpAndSettle();
      textFieldKey.currentState?.reset();

      expect(textFieldKey.currentState?.value, null);
    });
    testWidgets('Should reset to initial when call reset', (tester) async {
      const widgetName = 'sc1';
      final textFieldKey = GlobalKey<FormBuilderFieldState>();
      const initialValue = 'test';
      final testWidget = FormBuilderCupertinoTextField(
        name: widgetName,
        key: textFieldKey,
        initialValue: initialValue,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      textFieldKey.currentState?.setValue('hola');
      await tester.pumpAndSettle();
      textFieldKey.currentState?.reset();

      expect(textFieldKey.currentState?.value, equals(initialValue));
    });
    testWidgets(
      'Should reset custom error when invalidate field and then reset',
      (tester) async {
        const widgetName = 'sc1';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        const errorTextField = 'error text field';
        final testWidget = FormBuilderCupertinoTextField(
          name: widgetName,
          key: textFieldKey,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        textFieldKey.currentState?.invalidate(errorTextField);
        await tester.pumpAndSettle();

        // Reset custom error
        textFieldKey.currentState?.reset();
        await tester.pumpAndSettle();
        expect(find.text(errorTextField), findsNothing);
      },
    );
  });
}
