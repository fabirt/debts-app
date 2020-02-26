class DebtModel {
  int id;
  int debtorId;
  String date;
  double value;
  String description;

  DebtModel({
    this.id,
    this.debtorId,
    this.date,
    this.description,
    this.value = 0.0,
  });

  factory DebtModel.fromJson(Map<String, dynamic> json) {
    return DebtModel(
      id: json['id'],
      debtorId: json['debtor_id'],
      date: json['date'],
      value: json['value'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'debtor_id': debtorId,
      'date': date,
      'value': value,
      'description': description,
    };
  }
}
