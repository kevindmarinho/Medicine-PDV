import 'package:flutter/material.dart';
import 'package:med_app/modules/medicine_data/domain/entity/medicine_entity.dart';
import 'package:med_app/modules/medicines/data/datasource/medicines_datasource.dart';

class MedicinesController extends ChangeNotifier {
  final MedicinesDatasource medicinesDatasource;

  MedicinesController({required this.medicinesDatasource});

  List<MedicineEntity> _medicines = [];

  List<MedicineEntity> get medicines => _medicines;

  Future<void> loadMedicines() async {
    _medicines = List.of(await medicinesDatasource.getAllMedicines());
    notifyListeners();
  }

  Future<void> removeMedicine(int id) async {
    await medicinesDatasource.removeMedicine(id);
    _medicines.removeWhere((medicine) => medicine.id == id);
    notifyListeners();
  }

  Future<void> updateMedicine(int id, MedicineEntity updatedMedicine) async {
    final updatedEntity = MedicineEntity(
      id: id,
      name: updatedMedicine.name,
      description: updatedMedicine.description,
      qtd: updatedMedicine.qtd,
      classification: updatedMedicine.classification,
    );
    await medicinesDatasource.updateMedicine(id, updatedEntity);
    await loadMedicines();
  }
}
