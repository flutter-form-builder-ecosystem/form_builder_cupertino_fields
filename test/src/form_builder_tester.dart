import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

Widget buildTestableFieldWidget(
  Widget widget, {
  GlobalKey<FormBuilderState>? formKey,
  Map<String, dynamic> initialValue = const {},
  bool skipDisabled = false,
  bool clearValueOnUnregister = false,
  AutovalidateMode? autovalidateMode,
}) {
  return MaterialApp(
    home: Scaffold(
      body: FormBuilder(
        key: formKey ?? GlobalKey<FormBuilderState>(),
        skipDisabled: skipDisabled,
        initialValue: initialValue,
        clearValueOnUnregister: clearValueOnUnregister,
        autovalidateMode: autovalidateMode,
        child: widget,
      ),
    ),
  );
}
