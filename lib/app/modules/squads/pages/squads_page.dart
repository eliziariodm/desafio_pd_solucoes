import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../controllers/squads_controller.dart';
import '../../../core/ui/ui_button.dart';
import '../../../core/utils/app_images.dart';
import '../../home/widgets/squads_register_dialog.dart';
import '../views/squads_datatable_view.dart';

class SquadsPage extends StatelessWidget {
  const SquadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
          child: Consumer<SquadsController>(
            builder: (_, squads, __) {
              if (squads.squadsList.isEmpty) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 120),
                      Container(
                        height: 411,
                        width: 490,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 64),
                            SvgPicture.asset(AppImages.emoji),
                            const SizedBox(height: 24),
                            Text(
                              'Nenhuma squad cadastrada. Crie uma squad para começar.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 64),
                            UiButton(
                              textButton: 'Criar squad',
                              onPressedButton: () {
                                squads.clearText();

                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const SquadsRegisterDialog(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SquadsDataTableView();
              }
            },
          ),
        ),
      ),
    );
  }
}
