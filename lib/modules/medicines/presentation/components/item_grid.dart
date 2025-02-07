import 'package:flutter/material.dart';
import 'package:med_app/modules/medicine_data/domain/entity/medicine_entity.dart';
import 'package:med_app/modules/medicines/presentation/components/edit_modal.dart';
import 'package:med_app/modules/medicines/presentation/controllers/medicines_controller.dart';
import 'package:provider/provider.dart';

class ItemGrid extends StatelessWidget {
  final MedicinesController controller;

  const ItemGrid(
      {super.key,
      required this.controller,
      required List<MedicineEntity> medicineEntityList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<MedicinesController>(
        builder: (context, controller, child) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: controller.medicines.length,
            itemBuilder: (context, index) {
              final medicine = controller.medicines[index];
              final Color medicineColor =
                  _getColorFromValue(medicine.classification);

              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16.0)),
                    ),
                    builder: (context) => MedicineModal(
                      medicine: medicine,
                      controller: controller,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blueAccent,
                        Colors.white,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: DiagonalClipper(),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: medicineColor,
                        ),
                      ),
                      Center(
                        child: Text(
                          medicine.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _getColorFromValue(int value) {
    switch (value) {
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.white;
      case 3:
        return Colors.black;
      case 4:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

// Clipper personalizado para criar a faixa diagonal
class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Define o ponto inicial no canto superior direito
    path.moveTo(size.width, 0);
    // Define o ponto final no canto inferior esquerdo
    path.lineTo(size.width * 0.7,
        0); // Ajuste o valor para controlar a largura da faixa
    path.lineTo(size.width,
        size.height * 0.3); // Ajuste o valor para controlar a altura da faixa
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
