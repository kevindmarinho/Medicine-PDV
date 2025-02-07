import 'package:flutter/material.dart';
import 'package:med_app/modules/medicine_data/domain/entity/medicine_entity.dart';
import 'package:med_app/modules/new_medicine/data/datasource/new_medicine_datasource.dart';

class NewMedicineController extends ChangeNotifier {
  final NewMedicineDatasource newMedicineDatasource;
  MedicineEntity? medicineEntity;

  NewMedicineController({required this.newMedicineDatasource});

  Future<void> saveMedicine(
      String name, String description, int qtd, int classification) async {
    try {
      medicineEntity = MedicineEntity(
        id: 0,
        name: name,
        description: description,
        qtd: qtd,
        classification: classification,
      );

      medicineEntity?.id =
          await newMedicineDatasource.saveMedicine(medicineEntity!);
    } catch (e) {
      print('Erro ao salvar medicamento: $e');
    }
  }
}
