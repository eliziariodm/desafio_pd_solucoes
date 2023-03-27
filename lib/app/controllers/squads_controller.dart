import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../models/employees_model.dart';
import '../models/reports_model.dart';
import '../models/squads_model.dart';

class SquadsController extends ChangeNotifier {
  List<SquadsModel> squadsList = <SquadsModel>[];

  bool isDisable = true;

  TextEditingController nameTextController = TextEditingController();

  bool isTapInit = false;
  bool isTapEnd = false;
  TextEditingController initDateTextController = TextEditingController();
  TextEditingController endDateTextController = TextEditingController();
  bool isDisableDate = true;

  bool isFiltering = false;
  DateTime init = DateTime.now();
  DateTime end = DateTime.now();
  List<EmployeesModel> auxEmployeesList = <EmployeesModel>[];
  List<ReportsModel> auxReportsList = <ReportsModel>[];

  int sum = 0;
  double average = 0.0;

  bool isWarning = false;

  late Box box;
  late Box boxId;

  SquadsController() {
    _openBoxSquads();
  }

  _openBoxSquads() async {
    box = await Hive.openBox<SquadsModel>('squads');
    boxId = await Hive.openBox<int>('idSquads');
    await _readySquads();
  }

  _readySquads() async {
    for (var squads in box.keys) {
      SquadsModel squadsModel = await box.get(squads);
      squadsList.add(squadsModel);
      notifyListeners();
    }
  }

  createSquads() {
    var id = boxId.get('idSquads') ?? 0;

    id = id + 1;

    boxId.put('idSquads', id);

    squadsList.add(
      SquadsModel(id: id, name: nameTextController.text),
    );

    for (var squads in squadsList) {
      box.put(squads.id, SquadsModel(id: squads.id, name: squads.name));
    }

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

    auxEmployeesList = [];
    auxReportsList = [];
    sum = 0;
    average = 0.0;
    isWarning = false;

    for (var employeesModel in employeesList) {
      if (employeesModel.squadId == squadId) {
        for (var reportsModel in reportsList) {
          if (reportsModel.employeeId == employeesModel.id) {
            filterDate(employeesModel, reportsModel);
          }
        }
      }
    }

    notifyListeners();
  }

  filterDate(
    EmployeesModel employeesModel,
    ReportsModel reportsModel,
  ) {
    DateTime createAtDate = DateTime.parse(reportsModel.createdAt);

    if ((createAtDate.isAfter(init) || createAtDate.day == init.day) &&
        (createAtDate.isBefore(end) || createAtDate.day == end.day) &&
        init.isBefore(end)) {
      auxEmployeesList.add(employeesModel);

      auxReportsList.add(reportsModel);

      sumHours(auxReportsList);
      averageHours(auxReportsList);
    } else if (createAtDate.day == init.day && createAtDate.day == end.day) {
      auxEmployeesList.add(employeesModel);

      auxReportsList.add(reportsModel);

      sumHours(auxReportsList);
      averageHours(auxReportsList);
    } else {
      isWarning = true;
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
