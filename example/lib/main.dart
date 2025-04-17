import 'package:flutter/cupertino.dart';
import 'package:form_builder_cupertino_fields/form_builder_cupertino_fields.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Form Builder Cupertino Fields',
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: MyHomePage(title: 'Form Builder Cupertino Fields'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderCupertinoCheckbox(
                  name: 'checkbox',
                  prefix: const Text('Select/Unselect'),
                ),
                const SizedBox(height: 16),
                FormBuilderCupertinoSegmentedControl<int>(
                  name: 'segmented_control',
                  shouldExpandedField: true,
                  autovalidateMode: AutovalidateMode.always,
                  options: const [
                    FormBuilderFieldOption(value: 1, child: Text('First')),
                    FormBuilderFieldOption(value: 2, child: Text('Second')),
                    FormBuilderFieldOption(value: 3, child: Text('Third')),
                  ],
                  prefix: const Icon(CupertinoIcons.add),
                  validator: (value) => value != null ? null : 'Required field',
                  // initialValue: 1,
                ),
                const SizedBox(height: 16),
                FormBuilderCupertinoSlidingSegmentedControl<String>(
                  name: 'segmented_sliding_control',
                  options: const [
                    FormBuilderFieldOption(value: '1', child: Text('1')),
                    FormBuilderFieldOption(value: '2', child: Text('2')),
                    FormBuilderFieldOption(value: '3', child: Text('3')),
                  ],
                  helper: const Text('Select the numbers'),
                  prefix: const Icon(CupertinoIcons.number),
                ),
                const SizedBox(height: 16),
                FormBuilderCupertinoSwitch(
                  name: 'switch',
                  initialValue: true,
                  prefix: const Text('Enable/Disabled'),
                ),
                const SizedBox(height: 16),
                FormBuilderCupertinoSlider(
                  name: 'slider',
                  initialValue: 10,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  min: 1,
                  max: 100,
                  validator:
                      (value) =>
                          value != null && value < 50 && value > 5
                              ? null
                              : 'Required value between 5 and 50',
                ),
                const SizedBox(height: 16),
                FormBuilderCupertinoTextField(
                  name: 'text',
                  decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator:
                      (value) =>
                          value != null && value.length > 4
                              ? null
                              : 'Write a text',
                ),
                const SizedBox(height: 16),
                FormBuilderCupertinoDateTimePicker(
                  name: 'date',
                  prefix: const Icon(CupertinoIcons.calendar),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null ? null : 'Required date',
                  initialValue: DateTime.now(),
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
