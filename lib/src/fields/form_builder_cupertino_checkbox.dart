import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// On/Off Cupertino switch field
class FormBuilderCupertinoCheckbox extends FormBuilderField<bool> {
  /// The color to use when this radio button is selected.
  ///
  /// Defaults to [CupertinoColors.activeBlue].
  final Color? activeColor;

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

  /// A builder widget that is displayed underneath the [prefix] and [child] widgets.
  ///
  /// The [error] widget is primarily used to inform users of input errors. When
  /// a [Text] is given to [error], it will be shown in
  /// [CupertinoColors.destructiveRed] coloring and medium-weighted font. The
  /// row becomes taller in order to display the [helper] widget underneath
  /// [prefix] and [child]. If null, the row is shorter.
  final Widget? Function(String error)? errorBuilder;

  /// The color to use when this radio button is not selected.
  ///
  /// Defaults to [CupertinoColors.white].
  final Color? inactiveColor;

  /// The color for the radio's border when it has the input focus.
  ///
  /// If null, then a paler form of the [activeColor] will be used.
  final Color? focusColor;

  /// The color to use for the check icon when this checkbox is checked.
  ///
  /// If null, then the value of [CupertinoColors.white] is used.
  final Color? checkColor;

  /// If true, the checkbox's [value] can be true, false, or null.
  ///
  /// [CupertinoCheckbox] displays a dash when its value is null.
  ///
  /// When a tri-state checkbox ([tristate] is true) is tapped, its [onChanged]
  /// callback will be applied to true if the current value is false, to null if
  /// value is true, and to false if value is null (i.e. it cycles through false
  /// => true => null => false when tapped).
  ///
  /// If tristate is false (the default), [value] must not be null, and
  /// [onChanged] will only toggle between true and false.
  final bool tristate;

  /// The color and width of the checkbox's border.
  ///
  /// If this property is null, then the side defaults to a one pixel wide
  /// black, solid border.
  final BorderSide? side;

  /// The shape of the checkbox.
  ///
  /// If this property is null then the shape defaults to a
  /// [RoundedRectangleBorder] with a circular corner radius of 4.0.
  final OutlinedBorder? shape;

  /// Creates On/Off Cupertino switch field
  FormBuilderCupertinoCheckbox({
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
    this.activeColor,
    this.shouldExpandedField = false,
    this.errorBuilder,
    this.helper,
    this.contentPadding,
    this.prefix,
    this.focusColor,
    this.inactiveColor,
    this.checkColor,
    this.shape,
    this.side,
    this.tristate = false,
  }) : super(
          builder: (FormFieldState<bool?> field) {
            final state = field as _FormBuilderCupertinoCheckboxState;

            final fieldWidget = CupertinoCheckbox(
              focusColor: focusColor,
              focusNode: state.effectiveFocusNode,
              inactiveColor: inactiveColor,
              value: state.value ?? false,
              checkColor: checkColor,
              shape: shape,
              side: side,
              tristate: tristate,
              onChanged: state.enabled
                  ? (value) {
                      field.didChange(value);
                    }
                  : null,
              activeColor: activeColor,
            );
            return CupertinoFormRow(
              error: state.hasError
                  ? errorBuilder != null
                      ? errorBuilder(state.errorText ?? '')
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
  FormBuilderFieldState<FormBuilderCupertinoCheckbox, bool> createState() =>
      _FormBuilderCupertinoCheckboxState();
}

class _FormBuilderCupertinoCheckboxState
    extends FormBuilderFieldState<FormBuilderCupertinoCheckbox, bool> {}
