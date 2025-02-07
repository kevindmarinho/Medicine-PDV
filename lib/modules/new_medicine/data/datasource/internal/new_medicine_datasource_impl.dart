import 'package:med_app/modules/medicine_data/database/medicines_dao.dart';
import 'package:med_app/modules/medicine_data/database/medicines_dto.dart';
import 'package:med_app/modules/medicine_data/domain/entity/medicine_entity.dart';
import 'package:med_app/modules/new_medicine/data/datasource/new_medicine_datasource.dart';

class NewMedicineDatasourceImpl implements NewMedicineDatasource {
  final MedicinesDao medicinesDao;

  NewMedicineDatasourceImpl({required this.medicinesDao});

  @override
  Future<int> saveMedicine(MedicineEntity medicineEntity) async {
    MedicinesDto dto = _convertEntityToDTO(medicineEntity);
    return medicinesDao.saveMedicine(dto);
  }

  MedicinesDto _convertEntityToDTO(MedicineEntity medicine) {
    MedicinesDto dto = MedicinesDto();
    dto.name = medicine.name;
    dto.description = medicine.description;
    dto.qtd = medicine.qtd;
    dto.classification = medicine.classification;
    return dto;
  }
}
