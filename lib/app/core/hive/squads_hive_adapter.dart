import 'package:hive/hive.dart';

import '../../models/squads_model.dart';

class SquadsHiveAdapter extends TypeAdapter<SquadsModel> {
  @override
  final typeId = 2;

  @override
  SquadsModel read(BinaryReader reader) {
    return SquadsModel(
      id: reader.readInt(),
      name: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, SquadsModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
  }
}
