class Loan {
  int id;
  int lenderId;
  String date;
  double value;
  String description;

  Loan({
    this.id,
    this.lenderId,
    this.date,
    this.description,
    this.value = 0.0,
  });
}
