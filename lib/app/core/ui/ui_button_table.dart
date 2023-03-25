import 'package:flutter/material.dart';

class UiButtonTable extends StatelessWidget {
  final String textButton;
  final void Function()? onPressedButton;

  const UiButtonTable({
    super.key,
    required this.textButton,
    required this.onPressedButton,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33,
      width: 122,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        ),
        onPressed: onPressedButton,
        child: Text(
          textButton,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}
