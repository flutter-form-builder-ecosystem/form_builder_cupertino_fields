import 'package:flutter/cupertino.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

/// Field for selection of a numerical value on a slider
class FormBuilderCupertinoSlider extends FormBuilderField<double> {
  /// Called when the user starts selecting a new value for the slider.
  ///
  /// This callback shouldn't be used to update the slider [value] (use
  /// [onChanged] for that), but rather to be notified when the user has started
  /// selecting a new value by starting a drag or with a tap.
  ///
  /// The value passed will be the last [value] that the slider had before the
  /// change began.
  ///
  /// See also:
  ///
  ///  * [onChangeEnd] for a callback that is called when the value change is
  ///    complete.
  final ValueChanged<double>? onChangeStart;

  /// Called when the user is done selecting a new value for the slider.
  ///
  /// This callback shouldn't be used to update the slider [value] (use
  /// [onChanged] for that), but rather to know when the user has completed
  /// selecting a new [value] by ending a drag or a click.
  /// See also:
  ///
  ///  * [onChangeStart] for a callback that is called when a value change
  ///    begins.
  final ValueChanged<double>? onChangeEnd;

  /// The minimum value the user can select.
  ///
  /// Defaults to 0.0. Must be less than or equal to [max].
  ///
  /// If the [max] is equal to the [min], then the slider is disabled.
  final double min;

  /// The maximum value the user can select.
  ///
  /// Defaults to 1.0. Must be greater than or equal to [min].
  ///
  /// If the [max] is equal to the [min], then the slider is disabled.
  final double max;

  /// The number of discrete divisions.
  ///
  /// If null, the slider is continuous.
  final int? divisions;

  /// The color to use for the portion of the slider that has been selected.
  ///
  /// Defaults to the [CupertinoTheme]'s primary color if null.
  final Color? activeColor;

  /// The color to use for the thumb of the slider.
  ///
  /// Thumb color must not be null.
  ///
  /// Defaults to [CupertinoColors.white].
  final Color thumbColor;

  /// An alternative to displaying the text value of the slider.
  ///
  /// Defaults to null.
  ///
  /// When used [minValueWidget] will override the value for the minimum widget.
  final Widget Function(String min)? minValueWidget;

  /// An alternative to displaying the text value of the slider.
  ///
  /// Defaults to null.
  ///
  /// When used [valueWidget] will override the value for the selected value widget.
  final Widget Function(String value)? valueWidget;

  /// An alternative to displaying the text value of the slider.
  ///
  /// Defaults to null.
  ///
  /// When used [maxValueWidget] will override the value for the maximum widget.
  final Widget Function(String max)? maxValueWidget;

  /// Provides the ability to format a number in a locale-specific way.
  ///
  /// The format is specified as a pattern using a subset of the ICU formatting
  /// patterns.
  ///
  /// - `0` A single digit
  /// - `#` A single digit, omitted if the value is zero
  /// - `.` Decimal separator
  /// - `-` Minus sign
  /// - `,` Grouping separator
  /// - `E` Separates mantissa and expontent
  /// - `+` - Before an exponent, to say it should be prefixed with a plus sign.
  /// - `%` - In prefix or suffix, multiply by 100 and show as percentage
  /// - `‰ (\u2030)` In prefix or suffix, multiply by 1000 and show as per mille
  /// - `¤ (\u00A4)` Currency sign, replaced by currency name
  /// - `'` Used to quote special characters
  /// - `;` Used to separate the positive and negative patterns (if both present)
  ///
  /// For example,
  ///
  ///       var f = NumberFormat("###.0#", "en_US");
  ///       print(f.format(12.345));
  ///           ==> 12.34
  ///
  /// If the locale is not specified, it will default to the current locale. If
  /// the format is not specified it will print in a basic format with at least
  /// one integer digit and three fraction digits.
  ///
  /// There are also standard patterns available via the special constructors.
  /// e.g.
  ///
  ///       var percent = NumberFormat.percentPattern("ar"); var
  ///       eurosInUSFormat = NumberFormat.currency(locale: "en_US",
  ///           symbol: "€");
  ///
  /// There are several such constructors available, though some of them are
  /// limited. For example, at the moment, scientificPattern prints only as
  /// equivalent to "#E0" and does not take into account significant digits.
  final NumberFormat? numberFormat;

  final DisplayValues displayValues;

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

  /// Creates field for selection of a numerical value on a slider
  FormBuilderCupertinoSlider({
    super.key,
    required super.name,
    super.validator,
    required double super.initialValue,
    super.onChanged,
    super.valueTransformer,
    super.enabled,
    super.onSaved,
    super.autovalidateMode,
    super.onReset,
    super.focusNode,
    super.restorationId,
    required this.min,
    required this.max,
    this.divisions,
    this.activeColor,
    this.thumbColor = CupertinoColors.white,
    this.onChangeStart,
    this.onChangeEnd,
    this.numberFormat,
    this.displayValues = DisplayValues.all,
    this.maxValueWidget,
    this.minValueWidget,
    this.valueWidget,
    this.errorBuilder,
    this.helper,
    this.contentPadding,
    this.prefix,
  }) : super(
          builder: (FormFieldState<double?> field) {
            final state = field as _FormBuilderCupertinoSliderState;
            final effectiveNumberFormat =
                numberFormat ?? NumberFormat.compact();

            final fieldWidget = Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: CupertinoSlider(
                    value: field.value!,
                    min: min,
                    max: max,
                    divisions: divisions,
                    activeColor: activeColor,
                    onChangeEnd: onChangeEnd,
                    onChangeStart: onChangeStart,
                    onChanged: state.enabled
                        ? (value) {
                            field.didChange(value);
                          }
                        : null,
                    thumbColor: thumbColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    if (displayValues != DisplayValues.none &&
                        displayValues != DisplayValues.current)
                      minValueWidget?.call(effectiveNumberFormat.format(min)) ??
                          Text(effectiveNumberFormat.format(min)),
                    if (displayValues != DisplayValues.none &&
                        displayValues != DisplayValues.minMax)
                      valueWidget?.call(
                              effectiveNumberFormat.format(field.value)) ??
                          Text(effectiveNumberFormat.format(field.value)),
                    if (displayValues != DisplayValues.none &&
                        displayValues != DisplayValues.current)
                      maxValueWidget?.call(effectiveNumberFormat.format(max)) ??
                          Text(effectiveNumberFormat.format(max)),
                  ],
                ),
              ],
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
              child: fieldWidget,
            );
          },
        );

  @override
  FormBuilderFieldState<FormBuilderCupertinoSlider, double> createState() =>
      _FormBuilderCupertinoSliderState();
}

class _FormBuilderCupertinoSliderState
    extends FormBuilderFieldState<FormBuilderCupertinoSlider, double> {}
