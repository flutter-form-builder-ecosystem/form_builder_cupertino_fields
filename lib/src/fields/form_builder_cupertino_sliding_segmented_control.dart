import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_cupertino_fields/src/widgets/cupertino_input_decoration.dart';

/// Field for selection of a value from the `CupertinoSegmentedControl`
class FormBuilderCupertinoSlidingSegmentedControl<T extends Object>
    extends FormBuilderField<T> {
  /// The color used to fill the background of the selected widget and as the text
  /// color of unselected widgets.
  ///
  /// Defaults to `theme.primaryColor` if null.
  final Color? thumbColor;

  /// The color used as the border around each widget.
  ///
  /// Defaults to `inputDecorationTheme.fillColor`
  /// `CupertinoColors.tertiarySystemFill` if null.
  final Color? backgroundColor;

  /// The CupertinoSegmentedControl will be placed inside this padding
  ///
  /// Defaults to `EdgeInsets.symmetric(vertical: 2, horizontal: 3)`
  final EdgeInsetsGeometry? padding;

  /// The list of options the user can select.
  final List<FormBuilderFieldOption<T>> options;

  /// Defines whether the field input expands to fill the entire width
  /// of the row field.
  ///
  /// By default `false`
  final bool shouldExpandedField;

  /// Creates field for selection of a value from the `CupertinoSegmentedControl`
  FormBuilderCupertinoSlidingSegmentedControl({
    super.key,
    required super.name,
    super.validator,
    super.initialValue,
    super.decoration,
    super.onChanged,
    super.valueTransformer,
    super.enabled,
    super.onSaved,
    super.autovalidateMode,
    super.onReset,
    super.focusNode,
    super.restorationId,
    required this.options,
    this.backgroundColor,
    this.thumbColor,
    this.padding,
    this.shouldExpandedField = false,
  }) : super(
          builder: (FormFieldState<T?> field) {
            final state =
                field as _FormBuilderCupertinoSlidingSegmentedControlState<T>;
            final theme = Theme.of(state.context);

            final fieldWidget = CupertinoSlidingSegmentedControl<T>(
              backgroundColor: backgroundColor ??
                  theme.inputDecorationTheme.fillColor ??
                  CupertinoColors.tertiarySystemFill,
              thumbColor: state.enabled
                  ? thumbColor ?? theme.primaryColor
                  : theme.disabledColor,
              groupValue: state.value,
              children: <T, Widget>{
                for (final option in options) option.value: option,
              },
              padding: padding ??
                  const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
              onValueChanged: (value) {
                state.enabled ? field.didChange(value) : field.reset();
              },
            );

            return CupertinoInputDecoration(
              fieldState: state,
              child: shouldExpandedField
                  ? SizedBox(width: double.infinity, child: fieldWidget)
                  : fieldWidget,
            );
          },
        );

  @override
  FormBuilderFieldState<FormBuilderCupertinoSlidingSegmentedControl<T>, T>
      createState() => _FormBuilderCupertinoSlidingSegmentedControlState();
}

class _FormBuilderCupertinoSlidingSegmentedControlState<T extends Object>
    extends FormBuilderFieldState<
        FormBuilderCupertinoSlidingSegmentedControl<T>, T> {}
