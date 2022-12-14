import 'package:app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode, nextFocus;
  final String title, hint;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final bool autofocus, absorbing;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final bool obscureText;
  final ValueChanged<bool> onFocusChange;
  final bool hasError;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final Iterable<String>? autofillHints;
  final VoidCallback? onEditingComplete;

  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.nextFocus,
    required this.title,
    this.hint = '',
    this.prefixIcon,
    required this.textInputType,
    required this.textInputAction,
    required this.textCapitalization,
    this.suffixIcon,
    this.absorbing = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.obscureText = false,
    required this.onFocusChange,
    this.hasError = false,
    this.errorText,
    this.validator,
    this.maxLength,
    this.inputFormatters,
    this.onChanged,
    this.autofillHints,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: AppTheme.primaryColor),
          ),
          const SizedBox(height: 3),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: hasError
                      ? Colors.red
                      : focusNode.hasFocus
                          ? Colors.grey.shade900
                          : Colors.grey.shade900,
                  width: 1.5,
                )),
            child: Row(
              children: [
                Expanded(
                  child: Focus(
                    onFocusChange: onFocusChange,
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      onChanged: onChanged,
                      keyboardType: textInputType,
                      textInputAction: textInputAction,
                      inputFormatters: inputFormatters,
                      textCapitalization: textCapitalization,
                      autofocus: autofocus,
                      maxLines: maxLines,
                      maxLength: maxLength,
                      obscureText: obscureText,
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade700),
                      autofillHints: autofillHints,
                      onEditingComplete: onEditingComplete,
                      decoration: InputDecoration(
                          hintText: title == 'Confirm Password'
                              ? "Confirm Password"
                              : title == "Handicap"
                                  ? "Ex. 12"
                                  : "Enter your $title here",
                          hintStyle: TextStyle(color: Colors.grey.shade700),
                          counterText: '',
                          // isDense: false,
                          // filled: true,
                          prefixIcon: prefixIcon,
                          // focusedBorder: const UnderlineInputBorder(),
                          fillColor: Colors.grey.shade400,
                          errorStyle: const TextStyle(color: Colors.red)),
                    ),
                  ),
                ),
                suffixIcon ?? const SizedBox(),
              ],
            ),
          ),
          if (hasError) const SizedBox(height: 5),
          if (hasError)
            Text(errorText ?? '', style: const TextStyle(color: Colors.red)),
        ],
      ),
    );
  }
}
