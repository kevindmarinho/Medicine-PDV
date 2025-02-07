import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:med_app/modules/medicine_data/domain/entity/medicine_entity.dart';
import 'package:med_app/modules/medicines/presentation/controllers/medicines_controller.dart';
import 'package:med_app/modules/new_medicine/presentation/new_medicine_view.dart';

class MedicineModal extends StatefulWidget {
  final MedicineEntity medicine;
  final MedicinesController controller;

  const MedicineModal(
      {super.key, required this.medicine, required this.controller});

  @override
  _MedicineModalState createState() => _MedicineModalState();
}

class _MedicineModalState extends State<MedicineModal> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _quantityController;
  MedicineColor? _selectedColor;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.medicine.name);
    _descriptionController =
        TextEditingController(text: widget.medicine.description);
    _quantityController =
        TextEditingController(text: widget.medicine.qtd.toString());

    // Certifique-se de que a correspondência seja feita corretamente
    _selectedColor = MedicineColor.values.firstWhere(
      (color) => color.value == widget.medicine.classification,
      orElse: () =>
          MedicineColor.yellow, // Defina uma cor padrão, como `yellow`
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.6,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.5),
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Editar Medicamento',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
              TextField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Quantidade'),
              ),
              const SizedBox(height: 16),
              const Text("Classificação",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: MedicineColor.values.map((color) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = color;
                        print('cor : $_selectedColor');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: _getColorFromEnum(color),
                        border: Border.all(
                          color: _selectedColor == color
                              ? Colors.blue
                              : Colors.transparent,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      widget.controller.removeMedicine(widget.medicine.id);
                      Modular.to.pop();
                    },
                    child: const Text('Deletar'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final updatedMedicine = MedicineEntity(
                        id: widget.medicine.id,
                        name: _nameController.text,
                        description: _descriptionController.text,
                        qtd: int.tryParse(_quantityController.text) ?? 0,
                        classification: _selectedColor?.value ?? 0,
                      );
                      await widget.controller
                          .updateMedicine(widget.medicine.id, updatedMedicine);
                      Modular.to.pop();
                    },
                    child: const Text('Salvar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColorFromEnum(MedicineColor color) {
    switch (color) {
      case MedicineColor.yellow:
        return Colors.yellow;
      case MedicineColor.white:
        return Colors.white;
      case MedicineColor.black:
        return Colors.black;
      case MedicineColor.red:
        return Colors.red;
    }
  }
}
