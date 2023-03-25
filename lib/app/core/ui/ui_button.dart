import 'package:flutter/material.dart';

class UiButton extends StatelessWidget {
  final String textButton;
  final void Function()? onPressedButton;
  final bool disable;

  const UiButton({
    super.key,
    required this.textButton,
    required this.onPressedButton,
    this.disable = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 182,
      child: ElevatedButton(
        onPressed: disable ? null : onPressedButton,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            disable
                ? const Color(0xFF4263EB).withOpacity(0.4)
                : const Color(0xFF4263EB),
          ),
        ),
        child: Text(
          textButton,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}
