# Form Builder Cupertino Fields

Additional form inputs fields with Cupertino style for [flutter_form_builder](https://pub.dev/packages/flutter_form_builder) package

[![Pub Version](https://img.shields.io/pub/v/form_builder_cupertino_fields?logo=flutter&style=for-the-badge)](https://pub.dev/packages/form_builder_cupertino_fields)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/flutter-form-builder-ecosystem/form_builder_cupertino_fields/base.yaml?branch=main&logo=github&style=for-the-badge)](https://github.com/flutter-form-builder-ecosystem/form_builder_cupertino_fields/actions/workflows/base.yaml)
[![Codecov](https://img.shields.io/codecov/c/github/flutter-form-builder-ecosystem/form_builder_cupertino_fields?logo=codecov&style=for-the-badge)](https://codecov.io/gh/flutter-form-builder-ecosystem/form_builder_cupertino_fields/)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/flutter-form-builder-ecosystem/form_builder_cupertino_fields?logo=codefactor&style=for-the-badge)](https://www.codefactor.io/repository/github/flutter-form-builder-ecosystem/form_builder_cupertino_fields)
___

- [Features](#features)
- [Inputs](#inputs)
- [Use](#use)
  - [Setup](#setup)
  - [Basic use](#basic-use)
- [Support](#support)
  - [Contribute](#contribute)
  - [Questions and answers](#questions-and-answers)
  - [Donations](#donations)
- [Roadmap](#roadmap)
- [Ecosystem](#ecosystem)
- [Thanks to](#thanks-to)

## Features

- Cupertino fields with `FormBuilderField` logic
- Only cupertino dependencies, without material imports

## Inputs

The currently supported fields include:

- `FormBuilderCupertinoSegmentedControl` - Segmented control using `CupertinoSegmentedControl`
- `FormBuilderCupertinoSlidingSegmentedControl` - Segmented control bar using `CupertinoSlidingSegmentedControl`
- `FormBuilderCupertinoSlider` - For selection of a numerical value on a slider
- `FormBuilderCupertinoSwitch` - On/Off switch field
- `FormBuilderCupertinoTextField` - A text field input

## Use

### Setup

No specific setup required: only install the dependency and use :)

### Basic use

```dart
final _formKey = GlobalKey<FormBuilderState>();

FormBuilder(
    key: _formKey,
    child:  FormBuilderCupertinoTextField(
        name: 'text',
        onChanged: (val) {
            print(val); // Print the text value write into TextField
        },
    ),
)
```

See [pub.dev example tab](https://pub.dev/packages/form_builder_cupertino_fields/example) or [github code](example/lib/main.dart) for more details

## Support

### Contribute

You have some ways to contribute to this packages

- Beginner: Reporting bugs or request new features
- Intermediate: Implement new features (from issues or not) and created pull requests
- Advanced: Join to [organization](#ecosystem) like a member and help coding, manage issues, dicuss new features and other things

 See [contribution file](https://github.com/flutter-form-builder-ecosystem/.github/blob/main/CONTRIBUTING.md) for more details

### Questions and answers

You can question or search answers on [Github discussion](https://github.com/flutter-form-builder-ecosystem/form_builder_cupertino_fields/discussions) or on [StackOverflow](https://stackoverflow.com/questions/tagged/flutter-form-builder)

### Donations

Donate or become a sponsor of Flutter Form Builder Ecosystem

[![Become a Sponsor](https://opencollective.com/flutter-form-builder-ecosystem/tiers/sponsor.svg?avatarHeight=56)](https://opencollective.com/flutter-form-builder-ecosystem)

## Roadmap

- Add more Cupertino fields

## Ecosystem

Take a look to [our awesome ecosystem](https://github.com/flutter-form-builder-ecosystem) and all packages in there

## Thanks to

[All constributors](https://github.com/flutter-form-builder-ecosystem/form_builder_cupertino_fields/graphs/contributors)
