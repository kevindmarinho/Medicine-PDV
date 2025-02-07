import 'package:med_app/modules/medicine_data/domain/entity/medicine_entity.dart';

abstract class MedicinesDatasource {
  Future<List<MedicineEntity>> getAllMedicines();
  Future<void> removeMedicine(int medicineId);
  Future<void> updateMedicine(
      int medicineId, MedicineEntity updatedMedicineDto);
}
