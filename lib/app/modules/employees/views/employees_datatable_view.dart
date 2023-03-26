import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/employees_controller.dart';
import '../../../core/responsiveness/screen_size.dart';
import '../../../core/ui/ui_button.dart';
import '../../home/widgets/employees_register_dialog.dart';

class EmployeesDataTableView extends StatelessWidget {
  const EmployeesDataTableView({Key? key}) : super(key: key);

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
                'Lista de Usuários',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 36),
              Container(
                height: screen.isMobile(context) ? 420 : 460,
                width: screen.isMobile(context) ? 330 : 807,
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
                        Expanded(
                          child: SingleChildScrollView(
                            child: DataTable(
                              columnSpacing:
                                  screen.isMobile(context) ? 30 : 190,
                              horizontalMargin:
                                  screen.isMobile(context) ? 30 : 50,
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
