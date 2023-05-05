import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../widgets/cupertino_input_decoration.dart';

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

  /// Creates On/Off Cupertino switch field
  FormBuilderCupertinoSwitch({
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
    this.activeColor,
    this.dragStartBehavior = DragStartBehavior.start,
    this.shouldExpandedField = false,
    this.trackColor,
    this.thumbColor,
  }) : super(
          builder: (FormFieldState<bool?> field) {
            final state = field as _FormBuilderSwitchState;

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

            return CupertinoInputDecoration(
              fieldState: state,
              child: shouldExpandedField
                  ? SizedBox(width: double.infinity, child: fieldWidget)
                  : fieldWidget,
            );
          },
        );

  @override
  FormBuilderFieldState<FormBuilderCupertinoSwitch, bool> createState() =>
      _FormBuilderSwitchState();
}

class _FormBuilderSwitchState
    extends FormBuilderFieldState<FormBuilderCupertinoSwitch, bool> {}
