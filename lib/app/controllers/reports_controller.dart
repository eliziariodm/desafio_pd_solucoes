import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../models/reports_model.dart';

class ReportsController extends ChangeNotifier {
  List<ReportsModel> reportsList = <ReportsModel>[];

  int id = 1;
  TextEditingController employeeIdTextController = TextEditingController();
  TextEditingController spentHoursTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  get formKey => _formKey;
  bool isWarning = true;
  String textValidate = '';
  bool isWarningUserEmployees = true;
  bool isWarningSpentHours = true;
  bool isWarningDescription = true;

  late Box box;

  ReportsController() {
    _openBoxReports();
  }

  _openBoxReports() async {
    box = await Hive.openBox<ReportsModel>('reports');
    await _readyReports();
  }

  _readyReports() async {
    for (var reports in box.keys) {
      ReportsModel reportsModel = await box.get(reports);
      reportsList.add(reportsModel);
      notifyListeners();
    }
  }

  createReports() {
    reportsList.add(
      ReportsModel(
        id: id++,
        employeeId: int.parse(employeeIdTextController.text),
        spentHours: int.parse(spentHoursTextController.text),
        description: descriptionTextController.text,
        createdAt: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      ),
    );

    for (var reports in reportsList) {
      box.put(
        reports.id,
        ReportsModel(
          id: reports.id,
          employeeId: reports.employeeId,
          spentHours: reports.spentHours,
          description: reports.description,
          createdAt: reports.createdAt,
        ),
      );
    }

    notifyListeners();
  }

  clearText() {
    employeeIdTextController.text = '';
    spentHoursTextController.text = '';
    descriptionTextController.text = '';

    isWarning = true;
    isWarningUserEmployees = true;
    isWarningSpentHours = true;
    isWarningDescription = true;
  }

  validateIdUserEmployees() {
    isWarning = false;
    isWarningUserEmployees = false;
    textValidate = 'Não existe usuário com este id.';

    notifyListeners();
  }

  validateZero() {
    isWarning = false;
    isWarningUserEmployees = false;
    textValidate = 'Apenas números maiores que 0';

    notifyListeners();
  }

  validateEmptyUserEmployees(String? value) {
    if (value!.isEmpty) {
      isWarning = false;
      isWarningUserEmployees = false;
      textValidate = 'Preencha os dados.';
    } else {
      isWarningUserEmployees = true;
    }
    notifyListeners();
  }

  validateEmptySpentHours(String? value) {
    if (value!.isEmpty) {
      isWarning = false;
      isWarningSpentHours = false;
      textValidate = 'Preencha os dados.';
    } else {
      isWarningSpentHours = true;
    }

    notifyListeners();
  }

  validateEmptyDescription(String? value) {
    if (value!.isEmpty) {
      isWarning = false;
      isWarningDescription = false;
      textValidate = 'Preencha os dados.';
    } else {
      isWarningDescription = true;
    }
    notifyListeners();
  }

  onClosed() {
    isWarning = true;

    notifyListeners();
  }
}
