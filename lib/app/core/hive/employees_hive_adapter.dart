import 'package:hive/hive.dart';

import '../../models/employees_model.dart';

class EmployeesHiveAdapter extends TypeAdapter<EmployeesModel> {
  @override
  final typeId = 0;

  @override
  EmployeesModel read(BinaryReader reader) {
    return EmployeesModel(
      id: reader.readInt(),
      name: reader.readString(),
      estimatedHours: reader.readInt(),
      squadId: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, EmployeesModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeInt(obj.estimatedHours);
    writer.writeInt(obj.squadId);
  }
}
