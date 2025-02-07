import 'package:flutter_modular/flutter_modular.dart';
import 'package:med_app/modules/medicine_data/medicine_data_module.dart';
import 'package:med_app/modules/new_medicine/data/datasource/internal/new_medicine_datasource_impl.dart';
import 'package:med_app/modules/new_medicine/data/datasource/new_medicine_datasource.dart';
import 'package:med_app/modules/new_medicine/presentation/controllers/new_medicine_controller.dart';
import 'package:med_app/modules/new_medicine/presentation/new_medicine_view.dart';
import 'package:provider/provider.dart';

class NewMedicineModule extends Module {
  @override
  void binds(Injector i) {
    i.add(NewMedicineController.new);
    addDataSources(i);
  }

  @override
  List<Module> get imports => [MedicineDataModule()];

  void addDataSources(Injector i) {
    i.add<NewMedicineDatasource>(NewMedicineDatasourceImpl.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => ChangeNotifierProvider(
        create: (_) => Modular.get<NewMedicineController>(),
        child: const NewMedicineView(),
      ),
    );
  }
}
