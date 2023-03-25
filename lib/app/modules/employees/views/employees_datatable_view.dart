import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/employees_controller.dart';
import '../../../core/ui/ui_button.dart';
import '../../home/widgets/employees_register_dialog.dart';

class EmployeesDataTableView extends StatelessWidget {
  const EmployeesDataTableView({Key? key}) : super(key: key);

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
              children: [
                const SizedBox(height: 60),
                Text(
                  'Lista de Usuários',
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
                  child: Consumer<EmployeesController>(
                    builder: (_, employees, __) {
                      return Column(
                        children: [
                          const SizedBox(height: 64),
                          DataTable(
                            columns: const [
                              DataColumn(label: Text('Nome')),
                              DataColumn(label: Text('Horas')),
                              DataColumn(label: Text('Squad ID')),
                            ],
                            rows: List<DataRow>.generate(
                              employees.employeesList.length,
                              (index) => DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      employees.employeesList[index].name,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      employees
                                          .employeesList[index].estimatedHours
                                          .toString(),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      employees.employeesList[index].squadId
                                          .toString(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 64),
                          UiButton(
                            textButton: 'Criar usuário',
                            onPressedButton: () {
                              employees.clearText();

                              showDialog(
                                context: context,
                                builder: (context) =>
                                    const EmployeesRegisterDialog(),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
