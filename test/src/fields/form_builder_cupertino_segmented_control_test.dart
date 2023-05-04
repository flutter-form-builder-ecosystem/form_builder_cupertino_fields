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
      final textFieldKey = GlobalKey<FormBuilderFieldState>();
      final testWidget = FormBuilderCupertinoSegmentedControl<String>(
        name: widgetName,
        initialValue: 'AM',
        key: textFieldKey,
        options: const [
          FormBuilderFieldOption(value: 'AM'),
          FormBuilderFieldOption(value: 'PM'),
        ],
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(textFieldKey.currentState!.value, equals('AM'));
    });
  });

  group('errors -', () {
    testWidgets('should error text when value is empty',
        (WidgetTester tester) async {
      const widgetName = 'sc1';
      const errorTextField = 'error text field';
      final textFieldKey = GlobalKey<FormBuilderFieldState>();
      final testWidget = FormBuilderCupertinoSegmentedControl<String>(
        name: widgetName,
        key: textFieldKey,
        options: const [
          FormBuilderFieldOption(value: 'AM'),
          FormBuilderFieldOption(value: 'PM'),
        ],
        validator: (value) =>
            value == null || value.isEmpty ? errorTextField : null,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      textFieldKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text(errorTextField), findsOneWidget);

      await tester.tap(find.text('PM'));
      await tester.pumpAndSettle();

      textFieldKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text(errorTextField), findsNothing);
    });
    testWidgets('should custom error text when invalidate field',
        (WidgetTester tester) async {
      const widgetName = 'sc1';
      const errorTextField = 'error text field';
      final textFieldKey = GlobalKey<FormBuilderFieldState>();
      final testWidget = FormBuilderCupertinoSegmentedControl<String>(
        name: widgetName,
        key: textFieldKey,
        options: const [
          FormBuilderFieldOption(value: 'AM'),
          FormBuilderFieldOption(value: 'PM'),
        ],
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      textFieldKey.currentState!.invalidate(errorTextField);
      await tester.pumpAndSettle();

      expect(find.text(errorTextField), findsOneWidget);
    });
    testWidgets('should not show error text when some option is selected',
        (WidgetTester tester) async {
      const widgetName = 'sc1';
      final textFieldKey = GlobalKey<FormBuilderFieldState>();
      const errorTextField = 'error text field';
      final testWidget = FormBuilderCupertinoSegmentedControl<String>(
        name: widgetName,
        key: textFieldKey,
        options: const [
          FormBuilderFieldOption(value: 'AM'),
          FormBuilderFieldOption(value: 'PM'),
        ],
        validator: (value) =>
            value == null || value.isEmpty ? errorTextField : null,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      await tester.tap(find.text('PM'));
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
      final testWidget = FormBuilderCupertinoSegmentedControl<String>(
        name: widgetName,
        key: textFieldKey,
        options: const [
          FormBuilderFieldOption(value: 'AM'),
          FormBuilderFieldOption(value: 'PM'),
        ],
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      textFieldKey.currentState?.setValue('AM');
      await tester.pumpAndSettle();
      textFieldKey.currentState?.reset();

      expect(textFieldKey.currentState?.value, null);
    });
    testWidgets('Should reset to initial when call reset', (tester) async {
      const widgetName = 'sc1';
      final textFieldKey = GlobalKey<FormBuilderFieldState>();
      const initialValue = 'AM';
      final testWidget = FormBuilderCupertinoSegmentedControl<String>(
        name: widgetName,
        key: textFieldKey,
        initialValue: initialValue,
        options: const [
          FormBuilderFieldOption(value: 'AM'),
          FormBuilderFieldOption(value: 'PM'),
        ],
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      textFieldKey.currentState?.setValue('PM');
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
      final testWidget = FormBuilderCupertinoSegmentedControl<String>(
        name: widgetName,
        key: textFieldKey,
        options: const [
          FormBuilderFieldOption(value: 'AM'),
          FormBuilderFieldOption(value: 'PM'),
        ],
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      textFieldKey.currentState?.invalidate(errorTextField);
      await tester.pumpAndSettle();

      // Reset custom error
      textFieldKey.currentState?.reset();
      await tester.pumpAndSettle();
      expect(find.text(errorTextField), findsNothing);
    });
  });
}
