import 'package:flutter/cupertino.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

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

  /// A widget that is displayed at the start of the row.
  ///
  /// The [prefix] parameter is displayed at the start of the row. Standard iOS
  /// guidelines encourage passing a [Text] widget to [prefix] to detail the
  /// nature of the row's [child] widget. If null, the [child] widget will take
  /// up all horizontal space in the row.
  final Widget? prefix;

  /// Content padding for the row.
  ///
  /// Defaults to the standard iOS padding for form rows. If no edge insets are
  /// intended, explicitly pass [EdgeInsets.zero] to [contentPadding].
  final EdgeInsetsGeometry? contentPadding;

  /// A widget that is displayed underneath the [prefix] and [child] widgets.
  ///
  /// The [helper] appears in primary label coloring, and is meant to inform the
  /// user about interaction with the child widget. The row becomes taller in
  /// order to display the [helper] widget underneath [prefix] and [child]. If
  /// null, the row is shorter.
  final Widget? helper;

  /// Creates field for selection of a value from the `CupertinoSegmentedControl`
  FormBuilderCupertinoSegmentedControl({
    super.key,
    required super.name,
    super.validator,
    super.initialValue,
    super.onChanged,
    super.valueTransformer,
    super.enabled,
    super.onSaved,
    super.autovalidateMode,
    super.onReset,
    super.focusNode,
    super.restorationId,
    super.errorBuilder,
    required this.options,
    this.borderColor,
    this.selectedColor,
    this.pressedColor,
    this.padding,
    this.unselectedColor,
    this.shouldExpandedField = false,
    this.helper,
    this.contentPadding,
    this.prefix,
  }) : super(
         builder: (FormFieldState<T?> field) {
           final state = field as _FormBuilderCupertinoSegmentedControlState<T>;
           final theme = CupertinoTheme.of(state.context);

           final fieldWidget = CupertinoSegmentedControl<T>(
             borderColor: borderColor ?? theme.primaryColor,
             selectedColor: selectedColor ?? theme.primaryColor,
             pressedColor: pressedColor ?? theme.primaryColor,
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

           return CupertinoFormRow(
             error: state.hasError
                 ? errorBuilder != null
                       ? errorBuilder(state.context, state.errorText ?? '')
                       : Text(state.errorText ?? '')
                 : null,
             helper: helper,
             padding: contentPadding,
             prefix: prefix,
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
