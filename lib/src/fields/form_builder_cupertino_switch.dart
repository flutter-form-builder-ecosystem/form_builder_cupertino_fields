import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

/// On/Off Cupertino switch field
class FormBuilderCupertinoSwitch extends FormBuilderField<bool> {
  /// The color to use for the track when the switch is on.
  ///
  /// If null and [applyTheme] is false, defaults to [CupertinoColors.systemGreen]
  /// in accordance to native iOS behavior. Otherwise, defaults to
  /// [CupertinoThemeData.primaryColor].
  ///
  /// See also:
  ///
  ///  * [inactiveTrackColor], the color to use for the track when the switch is off.
  final Color? activeTrackColor;

  /// The color to use for the background when the switch is off.
  ///
  /// Defaults to [CupertinoColors.secondarySystemFill] when null.
  final Color? trackColor;

  /// The color to use on the thumb when the switch is off.
  ///
  /// If this color is not opaque, it is blended against
  /// [CupertinoThemeData.scaffoldBackgroundColor], so as not to see through the
  /// thumb to the track underneath.
  ///
  /// If null, defaults to [thumbColor]. If that is also null,
  /// [CupertinoColors.white] is used.
  ///
  /// See also:
  ///
  ///  * [thumbColor], the color to use for the thumb when the switch is on.
  final Color? inactiveThumbColor;

  /// The color to use for the focus highlight for keyboard interactions.
  ///
  /// Defaults to [activeColor] with an opacity of 0.80, a brightness of 0.69
  /// and a saturation of 0.835.
  final Color? focusColor;

  /// The color to use for the accessibility label when the switch is on.
  ///
  /// Defaults to [CupertinoColors.white] when null.
  final Color? onLabelColor;

  /// The color to use for the accessibility label when the switch is off.
  ///
  /// Defaults to [Color.fromARGB(255, 179, 179, 179)]
  /// (or [Color.fromARGB(255, 255, 255, 255)] in high contrast) when null.
  final Color? offLabelColor;

  /// {@macro flutter.material.switch.activeThumbImage}
  final ImageProvider? activeThumbImage;

  /// {@macro flutter.material.switch.onActiveThumbImageError}
  final ImageErrorListener? onActiveThumbImageError;

  /// {@macro flutter.material.switch.inactiveThumbImage}
  final ImageProvider? inactiveThumbImage;

  /// {@macro flutter.material.switch.onInactiveThumbImageError}
  final ImageErrorListener? onInactiveThumbImageError;

  /// Handler called when the focus changes.
  ///
  /// Called with true if this widget's node gains focus, and false if it loses
  /// focus.
  final ValueChanged<bool>? onFocusChange;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@template flutter.cupertino.CupertinoSwitch.applyTheme}
  /// Whether to apply the ambient [CupertinoThemeData].
  ///
  /// If true, the track uses [CupertinoThemeData.primaryColor] for the track
  /// when the switch is on.
  ///
  /// Defaults to [CupertinoThemeData.applyThemeToAll].
  /// {@endtemplate}
  final bool? applyTheme;

  /// The color to use for the track when the switch is off.
  ///
  /// Defaults to [CupertinoColors.secondarySystemFill] when null.
  ///
  /// See also:
  ///
  ///  * [activeTrackColor], the color to use for the track when the switch is on.
  final Color? inactiveTrackColor;

  /// The color to use for the thumb when the switch is on.
  ///
  /// If this color is not opaque, it is blended against
  /// [CupertinoThemeData.scaffoldBackgroundColor], so as not to see through the
  /// thumb to the track underneath.
  ///
  /// Defaults to [CupertinoColors.white] when null.
  ///
  /// See also:
  ///
  ///  * [inactiveThumbColor], the color to use for the thumb when the switch is off.
  final Color? thumbColor;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  ///
  /// Resolved in the following states:
  ///  * [WidgetState.selected].
  ///  * [WidgetState.hovered].
  ///  * [WidgetState.focused].
  ///  * [WidgetState.disabled].
  ///
  /// {@tool snippet}
  /// This example resolves the [mouseCursor] based on the current
  /// [WidgetState] of the [CupertinoSwitch], providing a different [mouseCursor] when it is
  /// [WidgetState.disabled].
  ///
  /// ```dart
  /// CupertinoSwitch(
  ///   value: true,
  ///   onChanged: (bool value) { },
  ///   mouseCursor: WidgetStateProperty.resolveWith<MouseCursor>((Set<WidgetState> states) {
  ///     if (states.contains(WidgetState.disabled)) {
  ///       return SystemMouseCursors.click;
  ///     }
  ///     return SystemMouseCursors.basic; // All other states will use the default mouseCursor.
  ///   }),
  /// )
  /// ```
  /// {@end-tool}
  ///
  /// If null, then [MouseCursor.defer] is used when the switch is disabled.
  /// When the switch is enabled, [SystemMouseCursors.click] is used on Web, and
  /// [MouseCursor.defer] is used on other platforms.
  ///
  /// See also:
  ///
  ///  * [WidgetStateMouseCursor], a [MouseCursor] that implements
  ///    `WidgetStateProperty` which is used in APIs that need to accept
  ///    either a [MouseCursor] or a [WidgetStateProperty].
  final WidgetStateProperty<MouseCursor>? mouseCursor;

  /// The outline color of this [CupertinoSwitch]'s track.
  ///
  /// Resolved in the following states:
  ///  * [WidgetState.selected].
  ///  * [WidgetState.hovered].
  ///  * [WidgetState.focused].
  ///  * [WidgetState.disabled].
  ///
  /// {@tool snippet}
  /// This example resolves the [trackOutlineColor] based on the current
  /// [WidgetState] of the [CupertinoSwitch], providing a different [Color] when it is
  /// [WidgetState.disabled].
  ///
  /// ```dart
  /// CupertinoSwitch(
  ///   value: true,
  ///   onChanged: (bool value) { },
  ///   trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
  ///     if (states.contains(WidgetState.disabled)) {
  ///       return CupertinoColors.activeOrange.withOpacity(.48);
  ///     }
  ///     return null; // Use the default color.
  ///   }),
  /// )
  /// ```
  /// {@end-tool}
  ///
  /// The [CupertinoSwitch] track has no outline by default.
  final WidgetStateProperty<Color?>? trackOutlineColor;

  /// The outline width of this [CupertinoSwitch]'s track.
  ///
  /// Resolved in the following states:
  ///  * [WidgetState.selected].
  ///  * [WidgetState.hovered].
  ///  * [WidgetState.focused].
  ///  * [WidgetState.disabled].
  ///
  /// {@tool snippet}
  /// This example resolves the [trackOutlineWidth] based on the current
  /// [WidgetState] of the [CupertinoSwitch], providing a different outline width when it is
  /// [WidgetState.disabled].
  ///
  /// ```dart
  /// CupertinoSwitch(
  ///   value: true,
  ///   onChanged: (bool value) { },
  ///   trackOutlineWidth: WidgetStateProperty.resolveWith<double?>((Set<WidgetState> states) {
  ///     if (states.contains(WidgetState.disabled)) {
  ///       return 5.0;
  ///     }
  ///     return null; // Use the default width.
  ///   }),
  /// )
  /// ```
  /// {@end-tool}
  ///
  /// Since a [CupertinoSwitch] has no track outline by default, this parameter
  /// is set only if [trackOutlineColor] is provided.
  ///
  /// Defaults to 2.0 if a [trackOutlineColor] is provided.
  final WidgetStateProperty<double?>? trackOutlineWidth;

  /// The icon to use on the thumb of this switch.
  ///
  /// Resolved in the following states:
  ///  * [WidgetState.selected].
  ///  * [WidgetState.hovered].
  ///  * [WidgetState.focused].
  ///  * [WidgetState.disabled].
  ///
  /// {@tool snippet}
  /// This example resolves the [thumbIcon] based on the current
  /// [WidgetState] of the [CupertinoSwitch], providing a different [Icon] when it is
  /// [WidgetState.disabled].
  ///
  /// ```dart
  /// CupertinoSwitch(
  ///   value: true,
  ///   onChanged: (bool value) { },
  ///   thumbIcon: WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
  ///     if (states.contains(WidgetState.disabled)) {
  ///       return const Icon(Icons.close);
  ///     }
  ///     return null; // All other states will use the default thumbIcon.
  ///   }),
  /// )
  /// ```
  /// {@end-tool}
  ///
  /// If null, then the [CupertinoSwitch] does not have any icons on the thumb.
  final WidgetStateProperty<Icon?>? thumbIcon;

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
    super.errorBuilder,
    this.activeTrackColor,
    this.dragStartBehavior = DragStartBehavior.start,
    this.trackColor,
    this.thumbColor,
    this.shouldExpandedField = false,
    this.helper,
    this.contentPadding,
    this.prefix,
    this.focusColor,
    this.inactiveThumbColor,
    this.onLabelColor,
    this.offLabelColor,
    this.activeThumbImage,
    this.onActiveThumbImageError,
    this.inactiveThumbImage,
    this.onInactiveThumbImageError,
    this.onFocusChange,
    this.autofocus = false,
    this.applyTheme,
    this.inactiveTrackColor,
    this.mouseCursor,
    this.trackOutlineColor,
    this.trackOutlineWidth,
    this.thumbIcon,
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
             dragStartBehavior: dragStartBehavior,
             thumbColor: thumbColor,
             activeTrackColor: activeTrackColor,
             activeThumbImage: activeThumbImage,
             inactiveThumbImage: inactiveThumbImage,
             applyTheme: applyTheme,
             autofocus: autofocus,
             focusColor: focusColor,
             focusNode: focusNode,
             inactiveThumbColor: inactiveThumbColor,
             inactiveTrackColor: inactiveTrackColor,
             mouseCursor: mouseCursor,
             onActiveThumbImageError: onActiveThumbImageError,
             onInactiveThumbImageError: onInactiveThumbImageError,
             offLabelColor: offLabelColor,
             onLabelColor: onLabelColor,
             onFocusChange: onFocusChange,
             thumbIcon: thumbIcon,
             trackOutlineColor: trackOutlineColor,
             trackOutlineWidth: trackOutlineWidth,
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
  FormBuilderFieldState<FormBuilderCupertinoSwitch, bool> createState() =>
      _FormBuilderCupertinoSwitchState();
}

class _FormBuilderCupertinoSwitchState
    extends FormBuilderFieldState<FormBuilderCupertinoSwitch, bool> {}
