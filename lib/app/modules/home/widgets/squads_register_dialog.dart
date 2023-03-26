import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../controllers/squads_controller.dart';
import '../../../core/responsiveness/screen_size.dart';
import '../../../core/ui/ui_button.dart';
import '../../../core/ui/ui_textfield.dart';

class SquadsRegisterDialog extends StatelessWidget {
  const SquadsRegisterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = Provider.of<ScreenSize>(context);

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      titlePadding: const EdgeInsets.only(top: 44, bottom: 34),
      title: Text(
        'Criar Squad',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      content: SizedBox(
        height: 80,
        width: 314,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<SquadsController>(
              builder: (_, squads, __) {
                return UiTextField(
                  title: 'NOME DA SQUAD',
                  label: 'Digite o nome da squad',
                  textEditingController: squads.nameTextController,
                  inputFormatters: [LengthLimitingTextInputFormatter(13)],
                  overflow: screen.isMobile(context)
                      ? TextOverflow.ellipsis
                      : TextOverflow.clip,
                  onChanged: (value) {
                    squads.validateSquads(value);
                  },
                );
              },
            ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.only(bottom: 64),
      actions: [
        Center(
          child: Consumer<SquadsController>(
            builder: (_, squads, __) {
              return UiButton(
                textButton: 'Criar squad',
                disable: squads.isDisable,
                onPressedButton: () {
                  squads.createSquads();
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
