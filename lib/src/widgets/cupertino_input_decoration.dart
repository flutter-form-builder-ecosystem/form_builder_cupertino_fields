import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CupertinoInputDecoration<K extends FormBuilderField<T>, T>
    extends StatelessWidget {
  const CupertinoInputDecoration({
    super.key,
    required this.child,
    required this.fieldState,
  });

  final Widget child;
  final FormBuilderFieldState<K, T?> fieldState;

  @override
  Widget build(BuildContext context) {
    return CupertinoFormRow(
      error: fieldState.hasError
          ? Text(
              fieldState.decoration.errorText ?? '',
              style: fieldState.decoration.errorStyle,
              maxLines: fieldState.decoration.errorMaxLines,
            )
          : null,
      helper: (fieldState.decoration.helperText?.isNotEmpty ?? false)
          ? Text(
              fieldState.decoration.helperText ?? '',
              style: fieldState.decoration.helperStyle,
              maxLines: fieldState.decoration.helperMaxLines,
            )
          : null,
      padding: fieldState.decoration.contentPadding,
      prefix: fieldState.decoration.prefix,
      child: child,
    );
  }
}
