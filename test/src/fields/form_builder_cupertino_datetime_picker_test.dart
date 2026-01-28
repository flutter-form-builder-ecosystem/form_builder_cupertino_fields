import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_cupertino_fields/form_builder_cupertino_fields.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../form_builder_tester.dart';

void main() {
  group('FormBuilderCupertinoDateTimePicker Tests -', () {
    // Test for initial value
    testWidgets('should initialize with the given initial value',
        (WidgetTester tester) async {
      const widgetName = 'dateTimePicker';
      final pickerKey = GlobalKey<FormBuilderFieldState>();

      final testWidget = FormBuilderCupertinoDateTimePicker(
        name: widgetName,
        key: pickerKey,
        initialValue: DateTime(2025, 2, 19, 11, 56),
      );

      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(pickerKey.currentState!.value, DateTime(2025, 2, 19, 11, 56));
    });

    // Test for reset functionality
    testWidgets('should reset to initial value when reset is called',
        (WidgetTester tester) async {
      const widgetName = 'dateTimePicker';
      final pickerKey = GlobalKey<FormBuilderFieldState>();
      final initialValue = DateTime(2025, 2, 19, 11, 56);

      final testWidget = FormBuilderCupertinoDateTimePicker(
        name: widgetName,
        key: pickerKey,
        initialValue: initialValue,
      );

      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      // Change the value
      pickerKey.currentState?.setValue(DateTime(2025, 2, 20, 12, 0));
      await tester.pumpAndSettle();

      // Reset the field
      pickerKey.currentState?.reset();
      await tester.pumpAndSettle();

      expect(pickerKey.currentState?.value, equals(initialValue));
    });

    // Test for date and time selection
    testWidgets('should update value when a new date and time is selected',
        (WidgetTester tester) async {
      const widgetName = 'dateTimePicker';
      final pickerKey = GlobalKey<FormBuilderFieldState>();

      final testWidget = FormBuilderCupertinoDateTimePicker(
        name: widgetName,
        key: pickerKey,
        initialValue: DateTime(2025, 2, 19, 11, 56),
      );

      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      // Simulate tapping the text field to show the picker
      await tester.tap(find.byType(CupertinoTextField));
      await tester.pumpAndSettle();

      // Simulate selecting a new date and time
      final newDateTime = DateTime(2025, 2, 20, 12, 0);
      pickerKey.currentState?.didChange(newDateTime);
      await tester.pumpAndSettle();

      expect(pickerKey.currentState?.value, equals(newDateTime));
    });

    // Test for locale and format
    testWidgets('should display date in the correct format and locale',
        (WidgetTester tester) async {
      initializeDateFormatting();
      const widgetName = 'dateTimePicker';
      final pickerKey = GlobalKey<FormBuilderFieldState>();
      final initialValue = DateTime(2025, 2, 19, 11, 56);
      final dateFormat = DateFormat.yMMMMd('fr_FR'); // French locale

      final testWidget = FormBuilderCupertinoDateTimePicker(
        name: widgetName,
        key: pickerKey,
        initialValue: initialValue,
        format: dateFormat,
        locale: const Locale('fr', 'FR'),
      );

      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      // Verify that the displayed text matches the French date format
      final expectedText = dateFormat.format(initialValue);
      expect(find.text(expectedText), findsOneWidget);
    });
  });
}
