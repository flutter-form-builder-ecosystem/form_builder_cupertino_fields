import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

/**************** START Imported from flutter/material.dart ****************/

/// Initial display of a calendar date picker.
///
/// Either a grid of available years or a monthly calendar.
///
/// See also:
///
///  * [showDatePicker], which shows a dialog that contains a Material Design
///    date picker.
///  * [CalendarDatePicker], widget which implements the Material Design date picker.
enum DatePickerMode {
  /// Choosing a month and day.
  day,

  /// Choosing a year.
  year,
}

/// Interactive input mode of the time picker dialog.
///
/// In [TimePickerEntryMode.dial] mode, a clock dial is displayed and the user
/// taps or drags the time they wish to select. In TimePickerEntryMode.input]
/// mode, [TextField]s are displayed and the user types in the time they wish to
/// select.
///
/// See also:
///
/// * [showTimePicker], a function that shows a [TimePickerDialog] and returns
///   the selected time as a [Future].
enum TimePickerEntryMode {
  /// User picks time from a clock dial.
  ///
  /// Can switch to [input] by activating a mode button in the dialog.
  dial,

  /// User can input the time by typing it into text fields.
  ///
  /// Can switch to [dial] by activating a mode button in the dialog.
  input,

  /// User can only pick time from a clock dial.
  ///
  /// There is no user interface to switch to another mode.
  dialOnly,

  /// User can only input the time by typing it into text fields.
  ///
  /// There is no user interface to switch to another mode.
  inputOnly,
}

/// Mode of date entry method for the date picker dialog.
///
/// In [calendar] mode, a calendar grid is displayed and the user taps the
/// day they wish to select. In [input] mode, a [TextField] is displayed and
/// the user types in the date they wish to select.
///
/// [calendarOnly] and [inputOnly] are variants of the above that don't
/// allow the user to change to the mode.
///
/// See also:
///
///  * [showDatePicker] and [showDateRangePicker], which use this to control
///    the initial entry mode of their dialogs.
enum DatePickerEntryMode {
  /// User picks a date from calendar grid. Can switch to [input] by activating
  /// a mode button in the dialog.
  calendar,

  /// User can input the date by typing it into a text field.
  ///
  /// Can switch to [calendar] by activating a mode button in the dialog.
  input,

  /// User can only pick a date from calendar grid.
  ///
  /// There is no user interface to switch to another mode.
  calendarOnly,

  /// User can only input the date by typing it into a text field.
  ///
  /// There is no user interface to switch to another mode.
  inputOnly,
}
/**************** START Imported from flutter/material.dart ****************/

/// A [CupertinoDateTimePicker] that integrates with [FormBuilder].
class FormBuilderCupertinoDateTimePicker extends FormBuilderField<DateTime> {
  /// The date/time picker dialogs to show.
  final InputType inputType;

  /// Allow manual editing of the date/time. Defaults to true. If false, the
  /// picker(s) will be shown every time the field gains focus.
  // final bool editable;

  /// For representing the date as a string e.g.
  /// `DateFormat("EEEE, MMMM d, yyyy 'at' h:mma")`
  /// (Sunday, June 3, 2018 at 9:24pm)
  final DateFormat? format;

  /// The date the calendar opens to when displayed. Defaults to null.
  ///
  /// To preset the widget's value, use [initialValue] instead.
  final DateTime? initialDate;

  /// The earliest choosable date. Defaults to 1900.
  final DateTime? firstDate;

  /// The latest choosable date. Defaults to 2100.
  final DateTime? lastDate;

  final DateTime? currentDate;

  /// The initial time prefilled in the picker dialog when it is shown. Defaults
  /// to noon. Explicitly set this to `null` to use the current time.
  final TimeOfDay initialTime;

  /// Called when an enclosing form is saved. The value passed will be `null`
  /// if [format] fails to parse the text.
  // final FormFieldSetter<DateTime> onSaved;

  /// Corresponds to the [showDatePicker()] parameter. Defaults to
  /// [DatePickerMode.day].
  final DatePickerMode initialDatePickerMode;

  /// Corresponds to the [showDatePicker()] parameter.
  ///
  /// See [GlobalMaterialLocalizations](https://docs.flutter.io/flutter/flutter_localizations/GlobalMaterialLocalizations-class.html)
  /// for acceptable values.
  final Locale? locale;

  /// Corresponds to the [showDatePicker()] parameter.
  final ui.TextDirection? textDirection;

  /// Corresponds to the [showDatePicker()] parameter.
  final bool useRootNavigator;

  /// Called when an enclosing form is submitted. The value passed will be
  /// `null` if [format] fails to parse the text.
  final ValueChanged<DateTime?>? onFieldSubmitted;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;

  /// Defines whether the field input expands to fill the entire width
  /// of the row field.
  ///
  /// By default `false`
  final bool shouldExpandedField;

  /// Controls the [BoxDecoration] of the box behind the text input.
  ///
  /// Defaults to having a rounded rectangle grey border and can be null to have
  /// no box decoration.
  final BoxDecoration? decoration;

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

  /// Preset the widget's value.
  final bool autofocus;
  final bool obscureText;
  final bool autocorrect;
  final MaxLengthEnforcement maxLengthEnforcement;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TransitionBuilder? transitionBuilder;

  /// Called whenever the state's value changes, e.g. after picker value(s)
  /// have been selected or when the field loses focus. To listen for all text
  /// changes, use the [controller] and [focusNode].
  // final ValueChanged<DateTime> onChanged;

  final bool showCursor;

  final int? minLines;

  final bool expands;

  final TextInputAction? textInputAction;

  final VoidCallback? onEditingComplete;

  final Radius cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;

  final double cursorWidth;
  final TextCapitalization textCapitalization;

  final DatePickerEntryMode initialEntryMode;
  final RouteSettings? routeSettings;

  final StrutStyle? strutStyle;
  final bool Function(DateTime day)? selectableDayPredicate;
  final Offset? anchorPoint;
  final void Function(TimePickerEntryMode mode)? onEntryModeChanged;
  final bool barrierDismissible;

  /// Creates field for `Date`, `Time` and `DateTime` input
  FormBuilderCupertinoDateTimePicker({
    super.key,
    required super.name,
    super.validator,
    super.initialValue,
    super.onChanged,
    super.valueTransformer,
    super.enabled,
    super.onSaved,
    super.autovalidateMode = AutovalidateMode.disabled,
    super.onReset,
    super.focusNode,
    super.restorationId,
    this.inputType = InputType.both,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.cursorWidth = 2.0,
    this.enableInteractiveSelection = true,
    this.initialTime = const TimeOfDay(hour: 12, minute: 0),
    this.keyboardType,
    this.textAlign = TextAlign.start,
    this.shouldExpandedField = false,
    this.decoration,
    this.prefix,
    this.contentPadding,
    this.helper,
    this.errorBuilder,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLines = 1,
    this.expands = false,
    this.initialDatePickerMode = DatePickerMode.day,
    this.transitionBuilder,
    this.textCapitalization = TextCapitalization.none,
    this.useRootNavigator = true,
    this.initialEntryMode = DatePickerEntryMode.calendar,
    this.format,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.currentDate,
    this.locale,
    this.maxLength,
    this.textDirection,
    this.textAlignVertical,
    this.onFieldSubmitted,
    this.controller,
    this.style,
    this.maxLengthEnforcement = MaxLengthEnforcement.none,
    this.inputFormatters,
    this.showCursor = false,
    this.minLines,
    this.textInputAction,
    this.onEditingComplete,
    this.cursorRadius = const Radius.circular(2.0),
    this.cursorColor,
    this.keyboardAppearance,
    this.routeSettings,
    this.strutStyle,
    this.selectableDayPredicate,
    this.anchorPoint,
    this.onEntryModeChanged,
    this.barrierDismissible = true,
  }) : super(
          builder: (FormFieldState<DateTime?> field) {
            final state = field as _FormBuilderCupertinoDateTimePickerState;

            final fieldWidget = FocusTraversalGroup(
              policy: ReadingOrderTraversalPolicy(),
              child: CupertinoTextField(
                onTap: () => state.showPicker(),
                textDirection: textDirection,
                textAlign: textAlign,
                textAlignVertical: textAlignVertical,
                maxLength: maxLength,
                autofocus: autofocus,
                decoration: decoration,
                readOnly: true,
                enabled: state.enabled,
                autocorrect: autocorrect,
                controller: state._textFieldController,
                focusNode: state.effectiveFocusNode,
                inputFormatters: inputFormatters,
                keyboardType: keyboardType,
                maxLines: maxLines,
                obscureText: obscureText,
                showCursor: showCursor,
                minLines: minLines,
                expands: expands,
                style: style,
                onEditingComplete: onEditingComplete,
                cursorColor: cursorColor,
                cursorRadius: cursorRadius,
                cursorWidth: cursorWidth,
                enableInteractiveSelection: enableInteractiveSelection,
                keyboardAppearance: keyboardAppearance,
                scrollPadding: scrollPadding,
                strutStyle: strutStyle,
                textCapitalization: textCapitalization,
                textInputAction: textInputAction,
                maxLengthEnforcement: maxLengthEnforcement,
              ),
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
  FormBuilderFieldState<FormBuilderCupertinoDateTimePicker, DateTime>
      createState() => _FormBuilderCupertinoDateTimePickerState();
}

class _FormBuilderCupertinoDateTimePickerState extends FormBuilderFieldState<
    FormBuilderCupertinoDateTimePicker, DateTime> {
  late TextEditingController _textFieldController;

  late DateFormat _dateFormat;

  @override
  void initState() {
    super.initState();
    _textFieldController = widget.controller ?? TextEditingController();
    _dateFormat = widget.format ?? _getDefaultDateTimeFormat();
    //setting this to value instead of initialValue here is OK since we handle initial value in the parent class
    final initVal = value;
    _textFieldController.text =
        initVal == null ? '' : _dateFormat.format(initVal);

    effectiveFocusNode.onKeyEvent = (node, event) {
      if (event is KeyDownEvent &&
          event.logicalKey == LogicalKeyboardKey.space &&
          node.hasFocus) {
        showPicker();
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    };
  }

  @override
  void dispose() {
    // Dispose the _textFieldController when initState created it
    if (null == widget.controller) {
      _textFieldController.dispose();
    }
    super.dispose();
  }

  DateFormat _getDefaultDateTimeFormat() {
    final languageCode = widget.locale?.languageCode;
    return switch (widget.inputType) {
      InputType.time => DateFormat.Hm(languageCode),
      InputType.date => DateFormat.yMd(languageCode),
      InputType.both => DateFormat.yMd(languageCode).add_Hms()
    };
  }

  Future<void> showPicker() async {
    await onShowPicker(value);
  }

  Future<DateTime?> onShowPicker(DateTime? currentValue) async {
    currentValue = value;
    DateTime? newValue;
    switch (widget.inputType) {
      case InputType.date:
        newValue = await _showDatePicker(currentValue);
        break;
      case InputType.time:
        if (!context.mounted) break;
        newValue = convert(await _showTimePicker(currentValue));
        break;
      case InputType.both:
        if (!context.mounted) break;
        final date = await _showDatePicker(currentValue);
        if (date != null) {
          if (!mounted) break;
          final time = await _showTimePicker(currentValue);
          if (time == null) {
            newValue = null;
          } else {
            newValue = combine(date, time);
          }
        }
        break;
    }
    if (!mounted) return null;
    final finalValue = newValue ?? currentValue;
    didChange(finalValue);
    return finalValue;
  }

  Future<DateTime?> _showDatePicker(DateTime? currentValue) async {
    DateTime? pickedDate;
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 250,
          child: Container(
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(
              top: false,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: currentValue ?? widget.initialDate,
                minimumDate: widget.firstDate,
                maximumDate: widget.lastDate,
                onDateTimeChanged: (DateTime newDateTime) {
                  pickedDate = newDateTime;
                },
              ),
            ),
          ),
        );
      },
    );
    return pickedDate;
  }

  Future<TimeOfDay?> _showTimePicker(DateTime? currentValue) async {
    TimeOfDay? pickedTime;
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 250,
          child: Container(
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(
              top: false,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: currentValue ??
                    DateTime(0, 0, 0, widget.initialTime.hour,
                        widget.initialTime.minute),
                onDateTimeChanged: (DateTime newDateTime) {
                  pickedTime = TimeOfDay(
                      hour: newDateTime.hour, minute: newDateTime.minute);
                },
              ),
            ),
          ),
        );
      },
    );
    return pickedTime;
  }

  /// Sets the hour and minute of a [DateTime] from a [TimeOfDay].
  DateTime combine(DateTime date, TimeOfDay? time) => DateTime(
      date.year, date.month, date.day, time?.hour ?? 0, time?.minute ?? 0);

  DateTime? convert(TimeOfDay? time) =>
      time == null ? null : DateTime(1, 1, 1, time.hour, time.minute);

  @override
  void didChange(DateTime? value) {
    super.didChange(value);
    _textFieldController.text =
        (value == null) ? '' : _dateFormat.format(value);
  }
}
