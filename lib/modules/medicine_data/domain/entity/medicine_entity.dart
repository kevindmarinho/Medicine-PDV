class MedicineEntity {
  int id;
  final String name;
  final String description;
  final int qtd;
  final int classification;

  MedicineEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.qtd,
      required this.classification});
}
