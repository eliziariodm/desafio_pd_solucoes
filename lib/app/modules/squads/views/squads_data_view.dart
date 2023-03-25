import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../controllers/employees_controller.dart';
import '../../../controllers/reports_controller.dart';
import '../../../controllers/squads_controller.dart';
import '../../../core/ui/ui_button.dart';
import '../../../core/ui/ui_textfield.dart';
import '../../../core/utils/app_images.dart';
import '../../../models/squads_model.dart';
import '../../home/widgets/employees_register_dialog.dart';
import '../widgets/container_date_widget.dart';

class SquadsDataView extends StatelessWidget {
  const SquadsDataView({super.key});

  @override
  Widget build(BuildContext context) {
    final squadsModel =
        ModalRoute.of(context)?.settings.arguments as SquadsModel;

    final employeesController = Provider.of<EmployeesController>(context);
    final reportsController = Provider.of<ReportsController>(context);

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 340),
                    Text(
                      squadsModel.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 36),
                Consumer<SquadsController>(
                  builder: (_, squads, __) {
                    return Container(
                      height: squads.isFiltering == false ? 550 : 700,
                      width: 1300,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 64),
                            Text(
                              'Horas por membro',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            const SizedBox(height: 32),
                            SizedBox(
                              width: 800,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: UiTextField(
                                      title: 'INÍCIO',
                                      label: '01/02/2022',
                                      isDate: true,
                                      textInputType: TextInputType.datetime,
                                      textEditingController:
                                          squads.initDateTextController,
                                      isTap: squads.isTapInit,
                                      onTap: () {
                                        squads.datepickerInit(context);
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Flexible(
                                    child: UiTextField(
                                      title: 'FIM',
                                      label: '01/02/2022',
                                      isDate: true,
                                      textInputType: TextInputType.datetime,
                                      textEditingController:
                                          squads.endDateTextController,
                                      isTap: squads.isTapEnd,
                                      onTap: () {
                                        squads.datepickerEnd(context);
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Flexible(
                                    flex: 1,
                                    child: UiButton(
                                      textButton: 'Filtrar por data',
                                      disable: squads.isDisableDate,
                                      onPressedButton: () {
                                        squads.filter(
                                          employeesController.employeesList,
                                          squadsModel.id,
                                          reportsController.reportsList,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            squads.isFiltering == false
                                ? Column(
                                    children: [
                                      const SizedBox(height: 32),
                                      SvgPicture.asset(AppImages.emoji),
                                      const SizedBox(height: 24),
                                      Consumer<EmployeesController>(
                                        builder: (_, employees, __) {
                                          return Text(
                                            employees.employeesList.isEmpty
                                                ? 'Nenhum usuário cadastrado nesta squad. Crie um usuário para começar.'
                                                : 'Nenhum intervalo de data selecionado. Selecione um intervalo para começar.',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 32),
                                      Consumer<EmployeesController>(
                                        builder: (_, employees, __) {
                                          return employees.employeesList.isEmpty
                                              ? UiButton(
                                                  textButton:
                                                      'Adicionar usuário',
                                                  onPressedButton: () {
                                                    employees.clearText();

                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          const EmployeesRegisterDialog(),
                                                    );
                                                  },
                                                )
                                              : const SizedBox.shrink();
                                        },
                                      ),
                                      const SizedBox(height: 34),
                                    ],
                                  )
                                : const ContainerDateWidget(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
