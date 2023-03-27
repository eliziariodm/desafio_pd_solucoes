import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/employees_model.dart';

class EmployeesController extends ChangeNotifier {
  List<EmployeesModel> employeesList = <EmployeesModel>[];

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

  late Box box;
  late Box boxId;

  EmployeesController() {
    _openBoxEmployees();
  }

  _openBoxEmployees() async {
    box = await Hive.openBox<EmployeesModel>('employees');
    boxId = await Hive.openBox<int>('idEmployees');
    await _readyEmployees();
  }

  _readyEmployees() async {
    for (var employees in box.keys) {
      EmployeesModel employeesModel = await box.get(employees);
      employeesList.add(employeesModel);
      notifyListeners();
    }
  }

  createEmployees() {
    var id = boxId.get('idEmployees') ?? 0;

    id = id + 1;

    boxId.put('idEmployees', id);

    employeesList.add(
      EmployeesModel(
        id: id,
        name: nameTextController.text,
        estimatedHours: int.parse(estimatedHoursTextController.text),
        squadId: int.parse(squadIdTextController.text),
      ),
    );

    for (var employees in employeesList) {
      box.put(
        employees.id,
        EmployeesModel(
          id: employees.id,
          name: employees.name,
          estimatedHours: employees.estimatedHours,
          squadId: employees.squadId,
        ),
      );
    }

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
