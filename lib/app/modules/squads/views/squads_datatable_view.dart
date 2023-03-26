import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/squads_controller.dart';
import '../../../core/responsiveness/screen_size.dart';
import '../../../core/ui/ui_button.dart';
import '../../../core/ui/ui_button_table.dart';
import '../../home/widgets/squads_register_dialog.dart';

class SquadsDataTableView extends StatelessWidget {
  const SquadsDataTableView({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = Provider.of<ScreenSize>(context);

    return Scaffold(
      body: Container(
        height: screen.totalHeight(context),
        width: screen.totalWidth(context),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: screen.isMobile(context)
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Text(
                'Lista de Squads',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 36),
              Container(
                height: screen.isMobile(context) ? 420 : 460,
                width: screen.isMobile(context) ? 330 : 820,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Consumer<SquadsController>(
                  builder: (_, squads, __) {
                    return Column(
                      children: [
                        const SizedBox(height: 64),
                        Expanded(
                          child: SingleChildScrollView(
                            child: DataTable(
                              columnSpacing:
                                  screen.isMobile(context) ? 20 : 170,
                              horizontalMargin:
                                  screen.isMobile(context) ? 20 : 45,
                              columns: const [
                                DataColumn(label: Text('ID')),
                                DataColumn(label: Text('Nome')),
                                DataColumn(label: Text('')),
                              ],
                              rows: List<DataRow>.generate(
                                squads.squadsList.length,
                                (index) => DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        squads.squadsList[index].id.toString(),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        squads.squadsList[index].name,
                                      ),
                                    ),
                                    DataCell(
                                      UiButtonTable(
                                        textButton: 'Visitar squad',
                                        onPressedButton: () {
                                          squads.clearDate();
                                          Navigator.pushNamed(
                                            context,
                                            '/squadsData',
                                            arguments: squads.squadsList[index],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                        const SizedBox(height: 60),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
