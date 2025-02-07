import 'package:med_app/modules/medicine_data/database/medicines_dao.dart';
import 'package:med_app/modules/medicine_data/database/medicines_dto.dart';
import 'package:med_app/modules/medicine_data/domain/entity/medicine_entity.dart';
import 'package:med_app/modules/medicines/data/datasource/medicines_datasource.dart';

class MedicinesDatasourceImpl implements MedicinesDatasource {
  final MedicinesDao medicinesDao;

  MedicinesDatasourceImpl({required this.medicinesDao});

  @override
  Future<List<MedicineEntity>> getAllMedicines() async =>
      await medicinesDao.getAllMedicines();

  @override
  Future<void> removeMedicine(int medicineId) async =>
      await medicinesDao.removeMedicine(medicineId);

  @override
  Future<void> updateMedicine(
      int medicineId, MedicineEntity updatedMedicineEntity) async {
    MedicinesDto dto = _convertEntityToDTO(updatedMedicineEntity);
    await medicinesDao.updateMedicine(medicineId, dto);
  }

  MedicinesDto _convertEntityToDTO(MedicineEntity medicine) {
    MedicinesDto dto = MedicinesDto();
    dto.name = medicine.name;
    dto.description = medicine.description;
    dto.classification = medicine.classification;
    dto.qtd = medicine.qtd;
    print('&& nome salvo ${dto.name}');
    return dto;
  }
}
