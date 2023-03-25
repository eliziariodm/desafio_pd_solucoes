import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UiTextField extends StatelessWidget {
  final String label;
  final String title;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final double? top;
  final double? bottom;
  final bool isWarning;
  final bool isDate;
  final bool isTap;

  const UiTextField({
    Key? key,
    required this.label,
    required this.title,
    this.textInputType,
    this.inputFormatters,
    this.textEditingController,
    this.validator,
    this.onChanged,
    this.onTap,
    this.top,
    this.bottom,
    this.isWarning = true,
    this.isDate = false,
    this.isTap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 7),
        TextFormField(
          cursorColor: Theme.of(context).colorScheme.surface,
          keyboardType: textInputType ?? TextInputType.name,
          inputFormatters: inputFormatters,
          controller: textEditingController,
          validator: validator,
          onChanged: onChanged,
          onTap: onTap,
          style: Theme.of(context).textTheme.headlineMedium,
          decoration: InputDecoration(
            suffixIcon: isWarning
                ? null
                : Icon(
                    Icons.warning_amber_rounded,
                    color: Theme.of(context).colorScheme.error,
                  ),
            prefixIcon: isDate
                ? Padding(
                    padding: const EdgeInsets.only(left: 20, right: 11),
                    child: Icon(
                      Icons.calendar_today,
                      color: isTap
                          ? Theme.of(context).colorScheme.onSecondary
                          : Theme.of(context).colorScheme.surface,
                    ),
                  )
                : null,
            errorStyle: const TextStyle(height: 0),
            contentPadding: EdgeInsets.only(
              left: 20,
              top: top ?? 0,
              bottom: bottom ?? 0,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text(
              isWarning ? label : 'Error',
              style: isWarning
                  ? Theme.of(context).textTheme.displayMedium
                  : Theme.of(context).textTheme.headlineMedium,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
