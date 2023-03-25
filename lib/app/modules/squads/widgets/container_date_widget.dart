import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controllers/squads_controller.dart';
import '../../../core/ui/ui_validate_container.dart';

class ContainerDateWidget extends StatelessWidget {
  const ContainerDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SquadsController>(
      builder: (_, squads, __) {
        return Column(
          children: [
            const SizedBox(height: 32),
            squads.auxReportsList.isEmpty
                ? squads.isWarning
                    ? const SizedBox.shrink()
                    : UiValidateContainer(
                        width: 400,
                        textValidate: 'Lance suas horas antes de filtrá-las.',
                        onTap: () {
                          squads.onClosedSquads();
                        },
                      )
                : DataTable(
                    columns: const [
                      DataColumn(label: Text('Membro')),
                      DataColumn(label: Text('Descrição')),
                      DataColumn(label: Text('Horas')),
                      DataColumn(label: Text('Criado em')),
                    ],
                    rows: List<DataRow>.generate(
                      squads.auxReportsList.length,
                      (index) {
                        var squadsDate = DateTime.parse(
                            squads.auxReportsList[index].createdAt);

                        var squadsStringDate =
                            DateFormat('dd/MM/yyyy').format(squadsDate);

                        return DataRow(
                          cells: [
                            DataCell(
                              Text(squads.auxEmployeesList[index].name),
                            ),
                            DataCell(
                              Text(squads.auxReportsList[index].description),
                            ),
                            DataCell(
                              Text(squads.auxReportsList[index].spentHours
                                  .toString()),
                            ),
                            DataCell(
                              Text(squadsStringDate),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
            const SizedBox(height: 32),
            Text(
              'Horas totais da squad',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 32),
            Text(
              '${squads.sum} Horas',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            Text(
              'Média de horas por dia',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 32),
            Text(
              '${squads.average.round()} Horas/Dia',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 34),
          ],
        );
      },
    );
  }
}
