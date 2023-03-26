import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../controllers/employees_controller.dart';
import '../../../controllers/reports_controller.dart';
import '../../../core/responsiveness/screen_size.dart';
import '../../../core/ui/ui_button.dart';
import '../../../core/ui/ui_textfield.dart';
import '../../../core/ui/ui_validate_container.dart';

class ReportsRegisterDialog extends StatelessWidget {
  const ReportsRegisterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final employeesController = Provider.of<EmployeesController>(context);
    final screen = Provider.of<ScreenSize>(context);

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      titlePadding: const EdgeInsets.only(top: 44, bottom: 34),
      title: Text(
        'Criar lançamento',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      content: Consumer<ReportsController>(
        builder: (_, reports, __) {
          return SizedBox(
            height: reports.isWarning ? 320 : 410,
            width: 330,
            child: Form(
              key: reports.formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    reports.isWarning
                        ? const SizedBox.shrink()
                        : UiValidateContainer(
                            textValidate: reports.textValidate,
                            onTap: reports.onClosed,
                          ),
                    reports.isWarning
                        ? const SizedBox.shrink()
                        : const SizedBox(height: 44),
                    UiTextField(
                      title: 'ID DO USUÁRIO',
                      label: 'Digite o ID do funcionário',
                      textEditingController: reports.employeeIdTextController,
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,1}')),
                      ],
                      overflow: screen.isMobile(context)
                          ? TextOverflow.ellipsis
                          : TextOverflow.clip,
                      isWarning: reports.isWarningUserEmployees,
                      validator: (value) {
                        if (value!.isEmpty) {
                          reports.validateEmptyUserEmployees(value);
                          return '';
                        } else if (int.parse(value) <= 0) {
                          reports.validateZero();
                          return '';
                        } else if (!employeesController.employeesList
                            .any((user) => user.id.toString() == value)) {
                          reports.validateIdUserEmployees();
                          return '';
                        } else {
                          reports.validateEmptyUserEmployees(value);
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                    UiTextField(
                      title: 'HORAS GASTAS',
                      label: 'Digite a quantidade de horas',
                      textEditingController: reports.spentHoursTextController,
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,1}')),
                      ],
                      overflow: screen.isMobile(context)
                          ? TextOverflow.ellipsis
                          : TextOverflow.clip,
                      isWarning: reports.isWarningSpentHours,
                      validator: (value) {
                        if (value!.isEmpty) {
                          reports.validateEmptySpentHours(value);
                          return '';
                        } else {
                          reports.validateEmptySpentHours(value);
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                    UiTextField(
                      title: 'DESCRIÇÃO',
                      label:
                          'Exemplo de texto de descrição da tarefa executada.',
                      textEditingController: reports.descriptionTextController,
                      isWarning: reports.isWarningDescription,
                      inputFormatters: [LengthLimitingTextInputFormatter(30)],
                      top: screen.isMobile(context) ? 10 : 35,
                      bottom: screen.isMobile(context) ? 10 : 35,
                      overflow: screen.isMobile(context)
                          ? TextOverflow.ellipsis
                          : TextOverflow.clip,
                      validator: (value) {
                        if (value!.isEmpty) {
                          reports.validateEmptyDescription(value);
                          return '';
                        } else {
                          reports.validateEmptyDescription(value);
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      actionsPadding: const EdgeInsets.only(bottom: 64),
      actions: [
        Center(
          child: Consumer<ReportsController>(builder: (_, reports, __) {
            return UiButton(
              textButton: 'Criar lançamento',
              onPressedButton: () {
                if (reports.formKey.currentState!.validate()) {
                  reports.createReports();
                  Navigator.pop(context);
                }
              },
            );
          }),
        ),
      ],
    );
  }
}
