import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../controllers/squads_controller.dart';
import '../../../core/responsiveness/screen_size.dart';
import '../../../core/ui/ui_button.dart';
import '../../../core/utils/app_images.dart';
import '../../home/widgets/squads_register_dialog.dart';
import '../views/squads_datatable_view.dart';

class SquadsPage extends StatelessWidget {
  const SquadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = Provider.of<ScreenSize>(context);

    return Scaffold(
      body: Container(
        height: screen.totalHeight(context),
        width: screen.totalWidth(context),
        padding: screen.isMobile(context)
            ? EdgeInsets.zero
            : EdgeInsets.only(left: screen.columnTwo(context)),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: Consumer<SquadsController>(
          builder: (_, squads, __) {
            if (squads.squadsList.isEmpty) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: screen.isMobile(context)
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Container(
                      height: screen.isMobile(context) ? 370 : 411,
                      width: screen.isMobile(context) ? 355 : 490,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 64),
                          SvgPicture.asset(
                            AppImages.emoji,
                            height: screen.isMobile(context) ? 98 : 128,
                          ),
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
                    const SizedBox(height: 40),
                  ],
                ),
              );
            } else {
              return const SquadsDataTableView();
            }
          },
        ),
      ),
    );
  }
}
