import 'package:flutter_modular/flutter_modular.dart';
import 'package:med_app/modules/medicines/medicine_module.dart';
import 'package:med_app/modules/new_medicine/new_medicine_module.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  List<Module> get imports => [];

  @override
  void routes(RouteManager r) {
    r.module(Modular.initialRoute, module: MedicineModule());
    r.module('/newMedicine', module: NewMedicineModule());
  }
}
