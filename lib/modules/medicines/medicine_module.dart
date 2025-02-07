import 'package:flutter_modular/flutter_modular.dart';
import 'package:med_app/modules/medicine_data/medicine_data_module.dart';
import 'package:med_app/modules/medicines/data/datasource/internal/medicines_datasource_impl.dart';
import 'package:med_app/modules/medicines/data/datasource/medicines_datasource.dart';
import 'package:med_app/modules/medicines/presentation/controllers/medicines_controller.dart';
import 'package:med_app/modules/medicines/presentation/list_medicine_view.dart';
import 'package:provider/provider.dart';

class MedicineModule extends Module {
  @override
  void binds(Injector i) {
    i.add(MedicinesController.new);
    addDataSources(i);
  }

  @override
  List<Module> get imports => [MedicineDataModule()];

  void addDataSources(Injector i) {
    i.add<MedicinesDatasource>(MedicinesDatasourceImpl.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => ChangeNotifierProvider(
        create: (_) => Modular.get<MedicinesController>(),
        child: const ListMedicineView(),
      ),
    );
  }
}
