import 'package:flutter/material.dart';

class UiValidateContainer extends StatelessWidget {
  final String textValidate;
  final void Function()? onTap;
  final double? width;

  const UiValidateContainer({
    super.key,
    required this.textValidate,
    required this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: width ?? 358,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error.withOpacity(0.1),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: ListTile(
        horizontalTitleGap: -3,
        leading: Icon(
          size: 27,
          Icons.warning_amber_rounded,
          color: Theme.of(context).colorScheme.error,
        ),
        title: Text(
          textValidate,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: InkWell(
          onTap: onTap,
          child: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
    );
  }
}
