import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/squads_controller.dart';
import '../../../core/ui/ui_button.dart';
import '../../../core/ui/ui_button_table.dart';
import '../../home/widgets/squads_register_dialog.dart';

class SquadsDataTableView extends StatelessWidget {
  const SquadsDataTableView({super.key});

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Text(
                  'Lista de Squads',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 36),
                Container(
                  height: 455,
                  width: 807,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Consumer<SquadsController>(builder: (_, squads, __) {
                    return Column(
                      children: [
                        const SizedBox(height: 64),
                        DataTable(
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
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
