import 'package:flutter/material.dart';

import '../../app/theme/spacing.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.obscureText = false,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ExcludeSemantics(
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: AppSpacing.small),
        Semantics(
          label: label,
          child: TextFormField(
            controller: controller,
            validator: validator,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            autofillHints: autofillHints,
            obscureText: obscureText,
            autocorrect: false,
            enableSuggestions: !obscureText,
            forceErrorText: errorText,
            decoration: InputDecoration(hintText: hint),
          ),
        ),
      ],
    );
  }
}
