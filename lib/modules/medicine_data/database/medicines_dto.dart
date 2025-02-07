import 'package:isar/isar.dart';

part 'medicines_dto.g.dart';

@collection
class MedicinesDto {
  Id id = Isar.autoIncrement;

  String? name;
  String? description;
  int? qtd;
  int? classification;
}
