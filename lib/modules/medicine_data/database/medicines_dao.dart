import 'package:isar/isar.dart';
import 'package:med_app/modules/medicine_data/database/medicines_dto.dart';
import 'package:med_app/modules/medicine_data/domain/entity/medicine_entity.dart';
import 'package:path_provider/path_provider.dart';

class MedicinesDao {
  static late Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([MedicinesDtoSchema], directory: dir.path);
  }

  Future<List<MedicineEntity>> getAllMedicines() async {
    var listMedicinesDto = await isar.medicinesDtos.where().findAll();
    var medicines = listMedicinesDto
        .map(
          (item) => MedicineEntity(
              id: item.id,
              name: item.name ?? '',
              description: item.description ?? '',
              qtd: item.qtd ?? 0,
              classification: item.classification ?? 0),
        )
        .toList();
    print('&& suposta lista $medicines');
    return medicines;
  }

  Future<int> saveMedicine(MedicinesDto medicineDto) async {
    return isar.writeTxn(() async {
      return await isar.medicinesDtos.put(medicineDto);
    });
  }

  Future<void> removeMedicine(int medicineId) async {
    isar.writeTxn(() async {
      await isar.medicinesDtos.delete(medicineId);
    });
  }

  Future<void> updateMedicine(
      int medicineId, MedicinesDto updatedMedicineDto) async {
    await isar.writeTxn(() async {
      final existingMedicine = await isar.medicinesDtos.get(medicineId);
      if (existingMedicine != null) {
        updatedMedicineDto.id = medicineId;
        await isar.medicinesDtos.put(updatedMedicineDto);
      }
    });
  }
}
