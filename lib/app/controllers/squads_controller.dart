import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/employees_model.dart';
import '../models/reports_model.dart';
import '../models/squads_model.dart';
import '../repositories/squads_repository.dart';

class SquadsController extends ChangeNotifier {
  final repository = SquadsRepository();

  List<SquadsModel> squadsList = <SquadsModel>[];

  bool isDisable = true;

  int id = 1;
  TextEditingController nameTextController = TextEditingController();

  bool isTapInit = false;
  bool isTapEnd = false;
  TextEditingController initDateTextController = TextEditingController();
  TextEditingController endDateTextController = TextEditingController();
  bool isDisableDate = true;

  bool isFiltering = false;
  DateTime init = DateTime.now();
  DateTime end = DateTime.now();
  List<EmployeesModel> auxList = <EmployeesModel>[];
  List<ReportsModel> list = <ReportsModel>[];

  int sum = 0;
  double average = 0.0;

  bool isWarning = false;

  createSquads() {
    squadsList.add(
      SquadsModel(id: id++, name: nameTextController.text),
    );
    notifyListeners();
  }

  clearText() {
    nameTextController.text = '';
    isDisable = true;
    notifyListeners();
  }

  clearDate() {
    initDateTextController.text = '';
    endDateTextController.text = '';
    isDisableDate = true;
    isFiltering = false;
    isTapInit = false;
    isTapEnd = false;
    notifyListeners();
  }

  validateSquads(String? value) {
    if (value!.isEmpty) {
      isDisable = true;
    } else {
      isDisable = false;
    }
    notifyListeners();
  }

  datepickerInit(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      isTapInit = true;
      initDateTextController.text = DateFormat('dd/MM/yyyy').format(pickedDate);

      init = pickedDate;
    }
    notifyListeners();
  }

  datepickerEnd(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      isTapEnd = true;
      isDisableDate = false;
      endDateTextController.text = DateFormat('dd/MM/yyyy').format(pickedDate);

      end = pickedDate;
    }
    notifyListeners();
  }

  filter(
    List<EmployeesModel> employeesList,
    int squadId,
    List<ReportsModel> reportsList,
  ) {
    if (employeesList.isNotEmpty) {
      isFiltering = true;
    }

    auxList = [];
    list = [];
    sum = 0;
    average = 0.0;
    isWarning = false;

    for (var employeesModel in employeesList) {
      if (employeesModel.squadId == squadId) {
        for (var reportsModel in reportsList) {
          if (reportsModel.employeeId == employeesModel.id) {
            filterDate(employeesModel, reportsModel, reportsList);
          }
        }
      }
    }

    notifyListeners();
  }

  filterDate(
    EmployeesModel employeesModel,
    ReportsModel reportsModel,
    List<ReportsModel> reportsList,
  ) {
    if (reportsModel.createdAt.isAfter(init) &&
        (reportsModel.createdAt.isBefore(end) ||
            reportsModel.createdAt.day == end.day) &&
        init.isBefore(end)) {
      auxList.add(employeesModel);

      list.add(reportsModel);

      sumHours(reportsList);
      averageHours(reportsList);
    } else if (reportsModel.createdAt.day == init.day &&
        reportsModel.createdAt.day == end.day) {
      auxList.add(employeesModel);

      list.add(reportsModel);

      sumHours(reportsList);
      averageHours(reportsList);
    }

    notifyListeners();
  }

  sumHours(List<ReportsModel> reportList) {
    sum = reportList
        .map((value) => value.spentHours)
        .fold(0, (prev, spentHours) => prev + spentHours);

    notifyListeners();
  }

  averageHours(List<ReportsModel> reportList) {
    average = reportList
            .map((value) => value.spentHours)
            .fold(0, (prev, spentHours) => prev + spentHours) /
        reportList.length;

    notifyListeners();
  }

  onClosedSquads() {
    isWarning = true;
    notifyListeners();
  }
}
