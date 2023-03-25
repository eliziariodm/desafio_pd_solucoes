import 'package:flutter/material.dart';

import '../models/employees_model.dart';
import '../repositories/employees_repository.dart';

class EmployeesController extends ChangeNotifier {
  final repository = EmployeesRepository();

  List<EmployeesModel> employeesList = <EmployeesModel>[];

  int id = 1;
  TextEditingController nameTextController = TextEditingController();
  TextEditingController estimatedHoursTextController = TextEditingController();
  TextEditingController squadIdTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  get formKey => _formKey;
  bool isWarning = true;
  String textValidate = '';
  bool isWarningName = true;
  bool isWarningEstimatedHours = true;
  bool isWarningSquadId = true;

  createEmployees() {
    employeesList.add(
      EmployeesModel(
        id: id++,
        name: nameTextController.text,
        estimatedHours: int.parse(estimatedHoursTextController.text),
        squadId: int.parse(squadIdTextController.text),
      ),
    );
    notifyListeners();
  }

  clearText() {
    nameTextController.text = '';
    estimatedHoursTextController.text = '';
    squadIdTextController.text = '';

    isWarning = true;
    isWarningName = true;
    isWarningEstimatedHours = true;
    isWarningSquadId = true;
  }

  onClosedEmployees() {
    isWarning = true;
    notifyListeners();
  }

  validateZero() {
    isWarning = false;
    isWarningSquadId = false;
    textValidate = 'Apenas números maiores que 0';

    notifyListeners();
  }

  validateIdSquad() {
    isWarning = false;
    isWarningSquadId = false;
    textValidate = 'Não existe squad com este id.';

    notifyListeners();
  }

  validateEmptyName(String? value) {
    if (value!.isEmpty) {
      isWarning = false;
      isWarningName = false;
      textValidate = 'Preencha os dados.';
    } else {
      isWarningName = true;
    }
    notifyListeners();
  }

  validateEmptyEstimatedHours(String? value) {
    if (value!.isEmpty) {
      isWarning = false;
      isWarningEstimatedHours = false;
      textValidate = 'Preencha os dados.';
    } else {
      isWarningEstimatedHours = true;
    }
    notifyListeners();
  }

  validateEmptySquadId(String? value) {
    if (value!.isEmpty) {
      isWarning = false;
      isWarningSquadId = false;
      textValidate = 'Preencha os dados.';
    } else {
      isWarningSquadId = true;
    }
    notifyListeners();
  }
}
