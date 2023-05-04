import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_cupertino_fields/src/widgets/cupertino_input_decoration.dart';

/// Field for selection of a value from the `CupertinoSegmentedControl`
class FormBuilderCupertinoSegmentedControl<T extends Object>
    extends FormBuilderField<T> {
  /// The color used to fill the backgrounds of unselected widgets and as the
  /// text color of the selected widget.
  ///
  /// Defaults to [CupertinoTheme]'s `primaryContrastingColor` if null.
  final Color? unselectedColor;

  /// The color used to fill the background of the selected widget and as the text
  /// color of unselected widgets.
  ///
  /// Defaults to [CupertinoTheme]'s `primaryColor` if null.
  final Color? selectedColor;

  /// The color used as the border around each widget.
  ///
  /// Defaults to [CupertinoTheme]'s `primaryColor` if null.
  final Color? borderColor;

  /// The color used to fill the background of the widget the user is
  /// temporarily interacting with through a long press or drag.
  ///
  /// Defaults to the selectedColor at 20% opacity if null.
  final Color? pressedColor;

  /// The CupertinoSegmentedControl will be placed inside this padding
  ///
  /// Defaults to EdgeInsets.symmetric(horizontal: 16.0)
  final EdgeInsetsGeometry? padding;

  /// The list of options the user can select.
  final List<FormBuilderFieldOption<T>> options;

  /// Defines whether the field input expands to fill the entire width
  /// of the row field.
  ///
  /// By default `false`
  final bool shouldExpandedField;

  /// Creates field for selection of a value from the `CupertinoSegmentedControl`
  FormBuilderCupertinoSegmentedControl({
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
    this.borderColor,
    this.selectedColor,
    this.pressedColor,
    this.padding,
    this.unselectedColor,
    this.shouldExpandedField = false,
  }) : super(
          builder: (FormFieldState<T?> field) {
            final state =
                field as _FormBuilderCupertinoSegmentedControlState<T>;
            final theme = Theme.of(state.context);

            final fieldWidget = CupertinoSegmentedControl<T>(
              borderColor: state.enabled
                  ? borderColor ?? theme.primaryColor
                  : theme.disabledColor,
              selectedColor: state.enabled
                  ? selectedColor ?? theme.primaryColor
                  : theme.disabledColor,
              pressedColor: state.enabled
                  ? pressedColor ?? theme.primaryColor
                  : theme.disabledColor,
              groupValue: state.value,
              children: <T, Widget>{
                for (final option in options) option.value: option,
              },
              padding: padding,
              unselectedColor: unselectedColor,
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
  FormBuilderFieldState<FormBuilderCupertinoSegmentedControl<T>, T>
      createState() => _FormBuilderCupertinoSegmentedControlState();
}

class _FormBuilderCupertinoSegmentedControlState<T extends Object>
    extends FormBuilderFieldState<FormBuilderCupertinoSegmentedControl<T>, T> {}
