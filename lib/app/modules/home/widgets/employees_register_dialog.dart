import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../controllers/employees_controller.dart';
import '../../../controllers/squads_controller.dart';
import '../../../core/ui/ui_button.dart';
import '../../../core/ui/ui_textfield.dart';
import '../../../core/ui/ui_validate_container.dart';

class EmployeesRegisterDialog extends StatelessWidget {
  const EmployeesRegisterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final squadsController = Provider.of<SquadsController>(context);

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      titlePadding: const EdgeInsets.only(top: 44, bottom: 34),
      title: Text(
        'Criar Usuário',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      content: Consumer<EmployeesController>(builder: (_, employees, __) {
        return SizedBox(
          height: employees.isWarning ? 310 : 410,
          width: 330,
          child: Form(
            key: employees.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                employees.isWarning
                    ? const SizedBox.shrink()
                    : UiValidateContainer(
                        textValidate: employees.textValidate,
                        onTap: employees.onClosedEmployees,
                      ),
                employees.isWarning
                    ? const SizedBox.shrink()
                    : const SizedBox(height: 44),
                UiTextField(
                  title: 'NOME DO USUÁRIO',
                  label: 'Digite o nome do usuário',
                  textEditingController: employees.nameTextController,
                  isWarning: employees.isWarningName,
                  validator: (value) {
                    if (value!.isEmpty) {
                      employees.validateEmptyName(value);
                      return '';
                    } else {
                      employees.validateEmptyName(value);
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 32),
                UiTextField(
                  title: 'HORAS ESTIMADAS DE TRABALHO',
                  label: 'Digite a quantidade de horas',
                  textEditingController: employees.estimatedHoursTextController,
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,1}')),
                  ],
                  isWarning: employees.isWarningEstimatedHours,
                  validator: (value) {
                    if (value!.isEmpty) {
                      employees.validateEmptyEstimatedHours(value);
                      return '';
                    } else {
                      employees.validateEmptyEstimatedHours(value);
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 32),
                UiTextField(
                  title: 'SQUAD',
                  label: 'Digite o Id da squad',
                  textEditingController: employees.squadIdTextController,
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,1}')),
                  ],
                  isWarning: employees.isWarningSquadId,
                  validator: (value) {
                    if (value!.isEmpty) {
                      employees.validateEmptySquadId(value);
                      return '';
                    } else if (int.parse(value) <= 0) {
                      employees.validateZero();
                      return '';
                    } else if (!squadsController.squadsList
                        .any((user) => user.id.toString() == value)) {
                      employees.validateIdSquad();
                      return '';
                    } else {
                      employees.validateEmptySquadId(value);
                      return null;
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }),
      actionsPadding: const EdgeInsets.only(bottom: 64),
      actions: [
        Center(
          child: Consumer<EmployeesController>(
            builder: (_, employees, __) {
              return UiButton(
                textButton: 'Criar usuário',
                onPressedButton: () {
                  if (employees.formKey.currentState!.validate()) {
                    employees.createEmployees();
                    Navigator.pop(context);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
