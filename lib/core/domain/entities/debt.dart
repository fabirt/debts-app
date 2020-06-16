class Debt {
  int id;
  int parentId;
  String date;
  double value;
  String description;

  Debt({
    this.id,
    this.parentId,
    this.date,
    this.description,
    this.value = 0.0,
  });
}
