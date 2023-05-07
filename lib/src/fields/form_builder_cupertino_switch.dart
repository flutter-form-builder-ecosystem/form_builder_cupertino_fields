import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

/// On/Off Cupertino switch field
class FormBuilderCupertinoSwitch extends FormBuilderField<bool> {
  /// The color to use when this switch is on.
  ///
  /// Defaults to [CupertinoColors.systemGreen] when null and ignores
  /// the [CupertinoTheme] in accordance to native iOS behavior.
  final Color? activeColor;

  /// The color to use for the background when the switch is off.
  ///
  /// Defaults to [CupertinoColors.secondarySystemFill] when null.
  final Color? trackColor;

  /// The color to use for the thumb of the switch.
  ///
  /// Defaults to [CupertinoColors.white] when null.
  final Color? thumbColor;

  /// {@template flutter.cupertino.CupertinoSwitch.dragStartBehavior}
  /// Determines the way that drag start behavior is handled.
  ///
  /// If set to [DragStartBehavior.start], the drag behavior used to move the
  /// switch from on to off will begin at the position where the drag gesture won
  /// the arena. If set to [DragStartBehavior.down] it will begin at the position
  /// where a down event was first detected.
  ///
  /// In general, setting this to [DragStartBehavior.start] will make drag
  /// animation smoother and setting it to [DragStartBehavior.down] will make
  /// drag behavior feel slightly more reactive.
  ///
  /// By default, the drag start behavior is [DragStartBehavior.start].
  ///
  /// See also:
  ///
  ///  * [DragGestureRecognizer.dragStartBehavior], which gives an example for
  ///    the different behaviors.
  ///
  /// {@endtemplate}
  final DragStartBehavior dragStartBehavior;

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

  /// Creates On/Off Cupertino switch field
  FormBuilderCupertinoSwitch({
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
    this.dragStartBehavior = DragStartBehavior.start,
    this.shouldExpandedField = false,
    this.trackColor,
    this.thumbColor,
    this.errorBuilder,
    this.helper,
    this.contentPadding,
    this.prefix,
  }) : super(
          builder: (FormFieldState<bool?> field) {
            final state = field as _FormBuilderCupertinoSwitchState;

            final fieldWidget = CupertinoSwitch(
              value: state.value ?? false,
              onChanged: state.enabled
                  ? (value) {
                      field.didChange(value);
                    }
                  : null,
              activeColor: activeColor,
              dragStartBehavior: dragStartBehavior,
              thumbColor: thumbColor,
              trackColor: trackColor,
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
  FormBuilderFieldState<FormBuilderCupertinoSwitch, bool> createState() =>
      _FormBuilderCupertinoSwitchState();
}

class _FormBuilderCupertinoSwitchState
    extends FormBuilderFieldState<FormBuilderCupertinoSwitch, bool> {}
