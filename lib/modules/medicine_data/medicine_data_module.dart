import 'package:flutter_modular/flutter_modular.dart';
import 'package:med_app/modules/medicine_data/database/medicines_dao.dart';

class MedicineDataModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addSingleton(MedicinesDao.new);
  }
}
