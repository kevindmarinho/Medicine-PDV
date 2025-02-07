import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:med_app/common/app_colors.dart';
import 'package:med_app/modules/medicines/presentation/components/item_grid.dart';
import 'package:med_app/modules/medicines/presentation/controllers/medicines_controller.dart';
import 'package:provider/provider.dart' as read_context;

class ListMedicineView extends StatefulWidget {
  const ListMedicineView({super.key});

  @override
  State<StatefulWidget> createState() => _ListMedicineViewState();
}

class _ListMedicineViewState extends State<ListMedicineView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      read_context.ReadContext(context)
          .read<MedicinesController>()
          .loadMedicines();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicines'),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              navigateToNewMedicine();
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryColor,
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: read_context.Consumer<MedicinesController>(
            builder: (context, controller, _) {
              return ItemGrid(
                medicineEntityList: controller.medicines,
                controller: controller,
              );
            },
          ),
        ),
      ),
    );
  }

  void navigateToNewMedicine() async {
    await Modular.to.pushNamed('/newMedicine');
    read_context.ReadContext(context)
        .read<MedicinesController>()
        .loadMedicines();
  }
}
