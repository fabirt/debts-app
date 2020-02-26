class Debt {
  int id;
  int debtorId;
  String date;
  double value;
  String description;

  Debt({
    this.id,
    this.debtorId,
    this.date,
    this.description,
    this.value = 0.0,
  });
}
