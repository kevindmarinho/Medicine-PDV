import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:med_app/common/app_colors.dart';
import 'package:med_app/modules/new_medicine/presentation/controllers/new_medicine_controller.dart';

class NewMedicineView extends StatefulWidget {
  const NewMedicineView({super.key});

  @override
  _NewMedicineViewState createState() => _NewMedicineViewState();
}

class _NewMedicineViewState extends State<NewMedicineView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  MedicineColor? _selectedColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Form"),
        backgroundColor: AppColors.primaryColor,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Text("Name",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Nome",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, insira o nome.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text("Quantidade",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Quantidade",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, insira a quantidade.";
                    }
                    if (int.tryParse(value) == null) {
                      return "Por favor, insira um número válido.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text("Descrição",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: "Descrição",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, insira uma descrição.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text("Classificação",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: MedicineColor.values.map((color) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = color;
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
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        _selectedColor != null) {
                      final controller = context.read<NewMedicineController>();
                      final int quantity = int.parse(_quantityController.text);

                      await controller.saveMedicine(
                        _nameController.text,
                        _descriptionController.text,
                        quantity,
                        _selectedColor!.value,
                      );

                      Modular.to.pop();
                    }
                  },
                  child: const Text("Enviar"),
                ),
              ],
            ),
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

//mover pra outra pasta

enum MedicineColor {
  yellow(1),
  white(2),
  black(3),
  red(4);

  final int value;
  const MedicineColor(this.value);
}
