import 'package:hive/hive.dart';

import '../../models/reports_model.dart';

class ReportsHiveAdapter extends TypeAdapter<ReportsModel> {
  @override
  final typeId = 1;

  @override
  ReportsModel read(BinaryReader reader) {
    return ReportsModel(
      id: reader.readInt(),
      employeeId: reader.readInt(),
      description: reader.readString(),
      spentHours: reader.readInt(),
      createdAt: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, ReportsModel obj) {
    writer.writeInt(obj.id);
    writer.writeInt(obj.employeeId);
    writer.writeString(obj.description);
    writer.writeInt(obj.spentHours);
    writer.writeString(obj.createdAt);
  }
}
