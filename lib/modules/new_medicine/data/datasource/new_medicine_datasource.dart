import 'package:med_app/modules/medicine_data/domain/entity/medicine_entity.dart';

abstract class NewMedicineDatasource {
  Future<int> saveMedicine(MedicineEntity medicineEntity);
}
